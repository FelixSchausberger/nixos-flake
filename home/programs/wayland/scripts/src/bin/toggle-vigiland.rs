use std::process::{Command, exit};
use sysinfo::{System, SystemExt, ProcessExt};

fn main() {
    // Create a new system instance and refresh the process list
    let mut system = System::new_all();
    system.refresh_all();

    // Check if the vigiland process is running
    let mut is_running = false;
    let mut pid_to_kill = 0;

    for (pid, process) in system.processes() {
        if process.name() == "vigiland" {
            is_running = true;
            pid_to_kill = (*pid).into(); // *pid;
            break;
        }
    }

    if is_running {
        // Kill the vigiland process
        if let Err(e) = Command::new("kill").arg(pid_to_kill.to_string()).status() {
            eprintln!("Failed to kill vigiland: {}", e);
            exit(1);
        } else {
            println!("Killed vigiland process with PID {}", pid_to_kill);
        }
    } else {
        // Start the vigiland process
        if let Err(e) = Command::new("vigiland").spawn() {
            eprintln!("Failed to start vigiland: {}", e);
            exit(1);
        } else {
            println!("Started vigiland process");
        }
    }
}


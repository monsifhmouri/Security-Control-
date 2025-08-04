MØNSTR-M1ND Security Control v3.0
Overview
MØNSTR-M1ND Security Control is a powerful Windows batch script designed for advanced user and session management. Built for security enthusiasts and system administrators, it provides a robust interface to monitor, manage, and secure local user accounts and active sessions on a Windows system. With a focus on precision and control, this tool empowers you to detect unauthorized access, terminate active sessions, and remove unwanted user accounts efficiently.
Developed by MØNSTR-M1ND, this script combines a sleek, professional interface with critical security features, making it an essential tool for safeguarding your system.
Features

User Account Management: List all local user accounts with their Security Identifiers (SIDs) for precise identification.
Session Monitoring: Display all active sessions, including Remote Desktop connections, with details like session ID, username, and state.
User Deletion: Safely delete user accounts with mandatory confirmation and automatic backups of user information.
Session Termination: Instantly terminate active sessions to disconnect unauthorized users.
Comprehensive Logging: Record all actions, errors, and user inputs in a dedicated log file for auditing and tracking.
Administrator Privilege Check: Ensures the script runs with the necessary permissions to perform sensitive operations.
User-Friendly Interface: Intuitive menu-driven navigation with color-coded feedback for a professional experience.

Requirements

Operating System: Windows (XP, 7, 8, 10, 11)
Privileges: Administrator rights are required to execute the script.
Disk Space: Minimal space for log files and backups (stored in C:\MØNSTR-M1ND_Logs\).

Installation

Download the script and save it as MØNSTR-M1ND_Security_Control.bat.
Right-click the file and select Run as Administrator to ensure proper functionality.

Usage

Launch the script as an Administrator.
Choose from the main menu options:
1. List all local users: Displays all user accounts with their SIDs.
2. List active sessions: Shows active sessions, including session IDs, usernames, and connection states.
3. Delete a user: Prompts for a username, verifies its existence, creates a backup, and deletes the account after confirmation.
4. Terminate a session: Prompts for a session ID and terminates the specified session.
5. Exit: Closes the script cleanly.


Follow the on-screen prompts to execute actions.
Check logs and backups in C:\MØNSTR-M1ND_Logs\ for detailed records.

Logging

All actions (user inputs, successes, errors) are logged in C:\MØNSTR-M1ND_Logs\security_control_YYYYMMDD.log.
User backups are saved as backup_USERNAME_YYYYMMDD.txt before deletion.

Security Notes

Run as Administrator: The script requires elevated privileges to manage users and sessions.
Backup Before Deletion: User information is automatically backed up before deletion to prevent accidental data loss.
Confirmation Prompts: Deletion and session termination require explicit confirmation to avoid unintended actions.
Limitations: This script manages local users and sessions. For advanced threats (e.g., malware or network-based attacks), use dedicated security tools like antivirus software or network monitors.

Example Workflow

Select option 1 to list users and identify suspicious accounts.
Use option 2 to check for unauthorized active sessions (e.g., Remote Desktop connections).
Use option 3 to delete a suspicious user account after confirming and backing up their data.
Use option 4 to terminate an active session by entering its ID.
Review logs in C:\MØNSTR-M1ND_Logs\ for a complete audit trail.

Disclaimer
This tool is designed for legitimate system administration and security purposes. Use it responsibly and only on systems you own or have explicit permission to manage. The developer is not responsible for any misuse or unintended consequences.
Author

MØNSTR-M1ND
Version: 3.0
Last Updated: August 2025

License
This project is provided as-is for personal and professional use. Ensure compliance with local laws and regulations when using this tool.

# 🛠️ Windows Network Toolkit

A personal command-line network troubleshooting kit for Windows,
built with batch scripts and PowerShell.

## Features
- Full network diagnostics with auto-saved logs
- nmap integration with a guided scan menu
- Quick commands: ipconfig, ping, netstat, DNS flush
- Network-wide host discovery and port scanning
- PowerShell health check with connectivity tests

## Requirements
- Windows 10/11
- [nmap](https://nmap.org/download.html) installed at `C:\Program Files (x86)\Nmap\`
- PowerShell 5.0+
- Run as **Administrator** for full functionality

## Setup
1. Clone this repo:
```bash
   git clone https://github.com/YOUR_USERNAME/windows-network-toolkit.git
```
2. Copy the folder to `C:\NetToolkit\`
3. Install nmap from https://nmap.org
4. Right-click `LaunchKit.bat` → Run as Administrator

## Usage
Run `LaunchKit.bat` and pick from the menu:

| Option | Description |
|--------|-------------|
| 1 | Full diagnostic — saves timestamped log |
| 2 | Quick ping test |
| 3 | View open/listening ports |
| 4 | Flush DNS cache |
| 5 | Release & renew IP |
| 6 | PowerShell health check |
| 7 | nmap scan menu |
| 8 | ipconfig |
| 9 | ipconfig /all |

## nmap Scan Types
| Option | Flag | Use Case |
|--------|------|----------|
| Ping scan | `-sn` | Find live hosts fast |
| Quick scan | `-F` | Top 100 ports |
| Full scan | `-p-` | All 65535 ports |
| Version | `-sV` | Detect service versions |
| OS detect | `-O` | Identify operating systems |
| Aggressive | `-A` | Full info (slow) |

## Logs
All diagnostic output is saved to `C:\NetToolkit\logs\` with timestamps.

## Disclaimer
Only scan networks you own or have explicit permission to scan.

## License
MIT

LORD OF DARKNESS - Elite Memory Dumper

**Lord of Darkness** is an advanced runtime memory extraction and threat intelligence framework designed for Termux and Linux environments. It performs dynamic analysis on suspicious binaries by capturing runtime memory dumps, allowing security researchers to uncover hidden threats, API keys, and exfiltration targets.

## 🚀 Features

- **Dynamic Runtime Extraction**: Uses GDB to hook into running processes and perform live memory dumps.
- **Threat Intelligence Engine**: Scans dumped memory payloads for malicious indicators.
- **Automated Dependency Management**: Automatically checks and installs required packages (GDB).
- **Categorized Findings**: Separates data into Critical (Tokens), Suspicious (IPs/URLs), and Safe indicators.
- **Interactive UI**: Clean, color-coded terminal interface for high-visibility threat analysis.

## 🛠 Prerequisites

- Termux or a Linux-based environment.
- `gdb` installed (The script handles this automatically).

## 📥 Installation

```bash
git clone https://github.com/NgaTon007/Lod-memory-dumping-.git

cd Lod-memory-dumping-

chmod +x install

chmod +x dumper.sh

./install

./dumper.sh

```

## 🔍 How It Works

1. **Target Selection**: Searches the device/storage for the specified binary file.
2. **Process Hooking**: Uses GDB `syscall 203` (sys_connect) to capture the memory state exactly when the binary attempts a network connection.
3. **Memory Dumping**: Generates a `.core` memory dump of the running process.
4. **Payload Analysis**: Utilizes `strings` and Regular Expressions (Regex) to extract sensitive data from the raw memory dump.
5. **Verdict Generation**: Analyzes the findings and presents a high-stakes risk assessment.

## 🛡 Risk Levels

* **CRITICAL**: Detects Telegram Bot Tokens, Discord Webhooks, and API Secrets.
* **SUSPICIOUS**: Identifies external URLs, IP addresses, and bot-related indicators.
* **CLEAN**: Identifies known system processes and normal environment data.

## ⚠️ Disclaimer
*This tool is intended for educational purposes and authorized security auditing only. Do not use this tool for unauthorized access or malicious activities. The author is not responsible for any misuse.*

👤 Author

**Nga Ton**


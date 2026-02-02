<div align="center">

 ![ASCII Logo](./logo.svg)
   
# Very Simple Network Chat
**Minimalist CMD chat for Windows networks** <br>
by Manuel Pollhammer (2026)

</div>

<p align="center">

</p>

---

## 🚀 What is VSNC?
**VSNC** is an ultra-lightweight chat client that runs entirely from a single Windows batch file. No installation, no server infrastructure — just pure efficiency directly in the [Windows Console](https://learn.microsoft.com).

### ✨ Highlights
- **Plug & Play:** Just start the `.bat` file and you’re good to go.
- **Network Chat:** Change the path in the variable `set CHAT=C:\Temp` to a **network drive** so multiple users can chat at the same time.
- **ANSI Styling:** Uses modern [ANSI escape sequences](https://en.wikipedia.org) for colorful, stylish output.
- **Ultra Portable:** Runs directly from a USB stick or a network share.

---

## 🛠️ Setup & Usage
1. Download `vsnc.bat`.
2. (Optional) Change the message storage location in the source code:
   ```batch
   set CHAT=\\YourServer\ChatShare
3. Start the file, enter your name, and press [W] to write messages.

## 🗺️ Roadmap & Future Plans
![planned](https://img.shields.io/badge/status-planned-orange) ㅤ**Chat-Encryption:** Encrypted chat file <br>
![planned](https://img.shields.io/badge/status-planned-orange) ㅤ**User Colors:** Random ANSI color per nickname <br>
![done](https://img.shields.io/badge/status-done-darkgreen)    ㅤ**Timestamps:** Automatic timestamps for messages. <br>

---

> [!IMPORTANT]
> **Security Notice:** Messages are stored in a plain .txt file and transmitted in clear text. Use VSNC preferably in trusted LAN or VPN environments.



![Alternativer Text](https://github.com/pollhammer/vsnc/blob/main/Screenshots/scrs_v1.1.png)

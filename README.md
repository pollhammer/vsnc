<div align="center">

# 💬 VSNC – Very Simple Net Chat
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
- [ ] **Chat-Encryption:** The content of the text file is encrypted and cannot be deciphered without a key.
- [ ] **User Colors:**  Randomly assigned ANSI color per user nickname.
- [ ] **Timestamps:** Automatic timestamps for messages.
---

## ⚖️ License & Security
This project is licensed under the **MIT License.**

> [!IMPORTANT]
> **Security Notice:** Messages are stored in a plain .txt file and transmitted in clear text. Use VSNC preferably in trusted LAN or VPN environments.



![Alternativer Text](https://github.com/pollhammer/vsnc/blob/main/Screenshots/screenshot01.png)
![Alternativer Text](https://github.com/pollhammer/vsnc/blob/main/Screenshots/screenshot02.png)
![Alternativer Text](https://github.com/pollhammer/vsnc/blob/main/Screenshots/screenshot03.png)
![Alternativer Text](https://github.com/pollhammer/vsnc/blob/main/Screenshots/screenshot04.png)

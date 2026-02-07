<div align="center">

 ![ASCII Logo](./logo.svg)
   
# Very Simple Network Chat <br> v2.1
**Minimalist CMD chat for Windows networks** <br>
by Manuel Pollhammer (2026)

</div>

<p align="center">

</p>

---

## 🚀 What is VSNC?
**VSNC** is an ultra-lightweight chat client that runs entirely from a single Windows batch file. No installation, no server infrastructure — just pure efficiency directly in the [Windows Console](https://en.wikipedia.org/wiki/Windows_Console).

### ✨ Highlights
- **Plug & Play:** Start the `.bat` file. No installation or dependencies needed. 🚀
- **Privacy-Encoded:** Messages are stored in 🟢**Base64**, 🔴not secure BUT **unreadable to curious eyes**. 😎
- **Network-Ready:** Set `CHAT=C:\Temp` to a **network drive** for live group chat. 🌐
- **Concurrency Stable:** Each user gets a temp file to avoid collisions & duplicates. 🔄
- **ANSI Styling:** Uses ANSI escape codes for colorful, professional output. 🎨
- **User Colors:** Each user gets a random color, saved and reused on next login. 🌈
- **Smart Maintenance:** Auto-trims chat history for small size and better performance. ⚡


---

## 🛠️ Setup & Usage
1. Download `vsnc.bat`.
2. (Optional) Change the message storage location in the source code:
   ```batch
   set CHAT=\\YourServer\ChatShare
3. Start the file, enter your name, and press [W] to write messages.

---

![Alternativer Text](https://github.com/pollhammer/vsnc/blob/main/Screenshots/scrs_v2.0_01.png)
<br>
![Alternativer Text](https://github.com/pollhammer/vsnc/blob/main/Screenshots/scrs_v2.0_02.png)


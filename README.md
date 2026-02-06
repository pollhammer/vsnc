<div align="center">

 ![ASCII Logo](./logo.svg)
   
# Very Simple Network Chat <br> v2.0
**Minimalist CMD chat for Windows networks** <br>
by Manuel Pollhammer (2026)

</div>

<p align="center">

</p>

---

## 🚀 What is VSNC?
**VSNC** is an ultra-lightweight chat client that runs entirely from a single Windows batch file. No installation, no server infrastructure — just pure efficiency directly in the [Windows Console](https://en.wikipedia.org/wiki/Windows_Console).

### ✨ Highlights
- **Plug & Play:** Just start the `.bat` file and you’re good to go. No installation or dependencies required. 🚀
- **Privacy-Encoded:** All messages are stored using **Base64 encoding** in the `chat.txt` file, making the raw logs unreadable to prying eyes. 🔒
- **Network-Ready:** Change the path in the variable `set CHAT=C:\Temp` to a **network drive** for real-time group chat. 🌐
- **Concurrency Stable:** Features unique temporary file handling per user to prevent data collisions and message duplicates. 🔄
- **ANSI Styling:** Uses modern ANSI Escape Sequences for professional, colorful output. 🎨
- **Smart Maintenance:** Automatically trims the chat history to keep the file size small and the performance lightning-fast. ⚡

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


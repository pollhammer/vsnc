<div align="center">

# 📟 VSNC – Very Simple Net Chat
**Minimalistischer CMD-Chat für Windows-Netzwerke**

</div>

<p align="center">

</p>

---

## 🚀 Was ist VSNC?
**VSNC** ist ein federleichter Chat-Client, der komplett in einer einzigen Windows-Batch-Datei läuft. Keine Installation, keine Server-Infrastruktur – pure Effizienz direkt über die [Windows Konsole](https://learn.microsoft.com).

### ✨ Highlights
- **Plug & Play:** Einfach die `.bat` Datei starten und loslegen.
- **Netzwerk-Chat:** Ändere den Pfad in der Variable `set CHAT=C:\Temp` auf ein **Netzlaufwerk**, damit mehrere Personen gleichzeitig chatten können.
- **ANSI-Optik:** Nutzt moderne [ANSI-Escapesequenzen](https://en.wikipedia.org) für stylische Farben.
- **Ultra-Portable:** Läuft direkt vom USB-Stick oder Netzlaufwerk.

---

## 🛠️ Einrichtung & Nutzung
1. Lade die `vsnc.bat` herunter.
2. (Optional) Ändere den Speicherort der Nachrichten im Quellcode:
   ```batch
   set CHAT=\\DeinServer\ChatFreigabe
3. Starte die Datei, gib deinen Namen ein und drücke **[W]**, um zu schreiben.

## 🗺️ Roadmap & Zukunft
- [ ] **Timestamps:** Automatische Zeitstempel für Nachrichten.
- [ ] **Auto-Cleanup:** Automatische Archivierung alter Chat-Inhalte.
- [ ] **Notifications:** Visuelle oder akustische Signale bei neuen Nachrichten.

---

## ⚖️ Lizenz & Sicherheit
Dieses Projekt steht unter der **MIT-Lizenz**.

> [!IMPORTANT]
> **Sicherheitshinweis:** Da die Nachrichten in einer einfachen `.txt` Datei gespeichert werden, erfolgt die Übertragung im Klartext. Nutze **VSNC** vorzugsweise in sicheren LAN- oder VPN-Umgebungen.



![Alternativer Text](https://github.com/pollhammer/vsnc/blob/main/Screenshots/screenshot01.png)
![Alternativer Text](https://github.com/pollhammer/vsnc/blob/main/Screenshots/screenshot02.png)
![Alternativer Text](https://github.com/pollhammer/vsnc/blob/main/Screenshots/screenshot03.png)
![Alternativer Text](https://github.com/pollhammer/vsnc/blob/main/Screenshots/screenshot04.png)

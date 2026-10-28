# 🛡️ Airwolf-Fortress: Automated System Hardening & Perimeter Killswitch Engine

> **Developer:** HanSolo - MOHD FIROZ HANIF  
> **Framework:** Universal Lab Deployment & Privacy Hardening Suite  
> **Target OS:** Arch Linux / Fedora Workstation
> **Run and tested: Debian,Arch,Fedora,Chromebook(arch linux)
> **RUN AS : SUDO
---
##IF YOU DO THIS AN CAUSE A NUCLEAR HOLOCAUST DONT COME CRYING TO ME!!!
PLEASE KNOW WHAT YOUR DOING AND DO SOME RESEARCH FIRST BEFORE YOU PROCEED. 
YOU MIGHT LOOSE YOU INTERNET CONNECTION IF YOU MESS IT UP OR FUCK IT UP!!
YET YOU WILL BE ON SQUID AND FIREWALLED IF YOU GET THIS RIGHT!!! HAHA
IF YOU DONT KNOW--GO AND ASK THE PRO!! THEY ARE THERE TO TEACH OTHERWISE READ A BOOK!!!


## 📂 Project Structure

```text
Airwolf-Fortress/
├── config/
│   └── squid.conf          # Ghost-mode Squid proxy configuration & header stripping
├── scripts/
│   └── airwolf-fortress.sh # Core iptables perimeter killswitch & loopback resolver lockdown
├── deploy.sh               # Master automated deployment & distribution profiling engine
└── .gitignore
🚀 Overview
Airwolf-Fortress is a robust, automated network perimeter and privacy-hardening script designed for Linux lab environments. It enforces a strict zero-trust posture by locking down kernel parameters, randomizing hardware MAC addresses, routing traffic exclusively through a hardened Squid proxy funnel, and dropping all unauthorized outbound packets via iptables.

⚙️ Core Architecture & Features
1. Automated Distribution Profiling (deploy.sh)
Dynamically detects the host operating system (Arch or Fedora).

Automatically adjusts the proxy system user profile (proxy for Arch, squid for Fedora).

Deploys systemctl protection matrices and forces aggressive NetworkManager MAC address randomization (cloned-mac-address=random) across wireless and ethernet interfaces.

2. Kernel Fingerprint Masquerading (99-security-morph.conf)
Modifies network stack parameters via sysctl:

Sets default IPv4 TTL to 128.

Disables TCP timestamps (net.ipv4.tcp_timestamps = 0) to prevent uptime fingerprinting.

Completely disables IPv6 (disable_ipv6 = 1) across all interfaces to eliminate dual-stack leaks.

3. Perimeter Killswitch & Funnel (airwolf-fortress.sh)
DNS Lockdown: Hardcodes /etc/resolv.conf to loopback (127.0.0.1) and sets the immutable bit (chattr +i) to prevent DNS leaks.

Aggressive Firewall Rules (iptables):

Flushes existing rules and sets default policies to DROP for INPUT, FORWARD, and OUTPUT.

Accepts local loopback (lo) and established/related connection states.

The Main Funnel: Blocks all general outbound traffic except for traffic owned explicitly by the proxy user (--uid-owner "$PROXY_USER"), forcing all system traffic through the local proxy tunnel.

4. Hardened Proxy Matrix (squid.conf)
Operates locally on 127.0.0.1:3128 using secure upstream DNS (9.9.9.9).

Anonymization & Privacy Shielding:

Strips identifying headers (Via, X-Forwarded-For, Proxy-Connection, Sec-CH-UA).

Deletes real User-Agent strings and spoofs them with a generic mobile Firefox profile (Mozilla/5.0 (Android 10; Mobile; rv:115.0)).

Hides server hostnames (visible_hostname none), suppresses version strings, and disables access logging to maintain zero local footprint.

📥 Deployment Instructions
Clone or place the repository in your workspace (e.g., /media/hansolo/SHARED/Airwolf-Fortress/).

Ensure root privileges and execute the master deployment script:

Bash
sudo ./deploy.sh
🔍 Verification
Once deployed, verify that your iptables rules are active and locked:

Bash
sudo iptables -L -v -n

HAVE FUN TRYING AND LEARNING.... AWESOME ...

THANK YOU
GOD BLESS.

#!/usr/bin/env bash
# =====================================================================
# AIRWOLF CORE PERIMETER KILLSWITCH
# Framework: Check, Verify, Test, and Deploy.
# Target OS: Linux Lab Infrastructure
# =====================================================================

# Ensure absolute root access
if [ "$EUID" -ne 0 ]; then
    echo "[!] Operational Failure: Root escalation required."
    exit 1
fi

# Detect proxy system user profile dynamically
if [ -f /etc/arch-release ]; then
    PROXY_USER="proxy"
else
    PROXY_USER="squid"
fi

echo "[-] Initializing Airwolf Funnel Framework..."

# Hardcode Resolver to Loopback Namespace
chattr -i /etc/resolv.conf 2>/dev/null
echo "nameserver 127.0.0.1" > /etc/resolv.conf
chattr +i /etc/resolv.conf

# Drop standard gates and compile kernel filters
iptables -F
iptables -X
iptables -P INPUT DROP
iptables -P FORWARD DROP
iptables -P OUTPUT DROP

# Loops and state preservation
iptables -A INPUT -i lo -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT
iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
iptables -A OUTPUT -p udp --dport 67:68 --sport 67:68 -j ACCEPT

# The Main Funnel Channel
iptables -A OUTPUT -m owner --uid-owner "$PROXY_USER" -j ACCEPT

# Save configuration states
mkdir -p /etc/iptables
iptables-save > /etc/iptables/iptables.rules
systemctl enable --now iptables 2>/dev/null || systemctl enable --now iptables.service 2>/dev/null

echo "[+] Airwolf Fortress perimeter active and locked."

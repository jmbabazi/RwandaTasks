#!/bin/bash
## Internet connection sharing script
WAN=enxda1d7240ff16
sysctl -w net.ipv4.ip_forward=1
sysctl -p
iptables -X
iptables -F
iptables -t nat -X
iptables -t nat -F
iptables -I INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -I FORWARD  -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -t nat -I POSTROUTING -o $WAN -j MASQUERADE



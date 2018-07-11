#!/bin/bash
#limpar todas as regras
iptables -F
iptables -t nat -F
iptables -t mangle -F
# Proteção contra port scanners ocultos
iptables -A INPUT -p tcp --tcp-flags SYN,ACK,FIN,RST, -m limit --limit 1/s -j ACCEPT
#Defesa: syncookies (evita ataques de DOS "Negação de serviços")
echo 1 > /proc/sys/net/ipv4/tcp_syncookies
#Defesa: rpfilter (evita ataque de spoofing "falsificação de IP")
echo 1 > /proc/sys/net/ipv4/conf/default/rp_filter
#Elimina pacotes invalidos (evita diversos tipos de ataques)
iptables -A INPUT -m state --state INVALID -j DROP
#Liberando acesso a interface de loopback:
iptables -A INPUT -p tcp -i lo -j ACCEPT
modprobe iptable_nat
iptables -t nat -A POSTROUTING -o enp0s3 -j MASQUERADE
echo 1 > /proc/sys/net/ipv4/ip_forward
#Liberando DNS:
iptables -A INPUT -p tcp --dport 53 -j ACCEPT
iptables -A INPUT -p udp --doprt 53 -j ACCEPT
#Liberando HTTP e HTTPS:
iptables -A INPUT -p tcp --dport 80 -j ACCEPT
iptables -A INPUT -p tcp --dport 443 -j ACCEPT
#liberar o envio e recebimento de email. obs Verificar portas junto ao provedor
iptables -A INPUT -p tcp --dport 110 -j ACCEPT
iptables -A INPUT -p tcp --dport 25 -j ACCEPT
#Liberando acesso via SSH:
iptables -A INPUT -p tcp --dport 22 -j ACCEPT
#Bloqueia as portas UDP de 0 : 1023 (com Exceção das abertas acima):
iptables -A INPUT -p udp --dport 0:1023 -j DROP
#Bloqueia as conexões nas demais portas:
#iptables -A INPUT -p tcp --syn -j DROP

#!/usr/bin/perl
# simple monitor of IPv6 DNS UDP packets
# the filter is looking for ann IPv6 UDP and IPv6 Frags on interface eth0
#
$tcp = "tcpdump -i eth0 -n  -vvv 'ip6 and ((ip6[6:1]==44) or (udp and port 53))'" ;
$cmd = "$tcp  | ./read_pcap.pl" ;
print("$cmd\n") ;
system("cmd") ;


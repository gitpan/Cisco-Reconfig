
my $config = readconfig("./testint");

# Extract interfaces where IPv4 addresses are configured

for my $item ($config->get('interface')->all) {
        my $ipaddr = $item->zoom->get('ip address');
        if ($ipaddr !~ /no/) {
                print $item-text;
		print "BLOCK\n" if $item->block;
		print "SINGLE\n" if $item->single;
                print $ipaddr;
        }
}

Input file (./testint) contains, say:

"
interface FastEthernet0/0.32
 description VLAN 32 to cit190-cs1
 bandwidth 100000
 encapsulation dot1Q 32
 ip address 218.185.30.57 255.255.255.252
 rate-limit input 100000000 18750000 37500000 conform-action transmit
exceed-action transmit
 rate-limit output 100000000 18750000 37500000 conform-action transmit
exceed-action transmit
 ip ospf cost 50
 no cdp enable
!

interface ATM2/0.10189 point-to-point
 description VC to agg1.que31 for Interim management
 bandwidth 1000
 ip address 172.17.64.90 255.255.255.252
 no ip redirects
 no ip proxy-arp
 pvc 10/189
  protocol ip 172.17.64.89
  ubr 1000
  encapsulation aal5snap
 !
"


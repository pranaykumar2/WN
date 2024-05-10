set val(chan)   Channel/WirelessChannel    ;# channel type
set val(prop)   Propagation/TwoRayGround   ;# radio-propagation model
set val(netif)  Phy/WirelessPhy            ;# network interface type
set val(mac)    Mac/802_11                 ;# MAC type
set val(ifq)    Queue/DropTail/PriQueue    ;# interface queue type
set val(ll)     LL                         ;# link layer type
set val(ant)    Antenna/OmniAntenna        ;# antenna model
set val(ifqlen) 50                         ;# max packet in ifq
set val(nn)     14                         ;# number of mobilenodes
set val(rp)     DSDV                       ;# routing protocol
set val(x)      1264                      ;# X dimension of topography
set val(y)      582                      ;# Y dimension of topography
set val(stop)   50.0                         ;# time of simulation end

#===================================
#        Initialization        
#===================================
#Create a ns simulator
set ns [new Simulator]

#Setup topography object
set topo       [new Topography]
$topo load_flatgrid $val(x) $val(y)
create-god $val(nn)

#Open the NS trace file
set tracefile [open out.tr w]
$ns trace-all $tracefile

#Open the NAM trace file
set namfile [open out.nam w]
$ns namtrace-all $namfile
$ns namtrace-all-wireless $namfile $val(x) $val(y)
set chan [new $val(chan)];#Create wireless channel

#===================================
#     Mobile node parameter setup
#===================================
$ns node-config -adhocRouting  $val(rp) \
                -llType        $val(ll) \
                -macType       $val(mac) \
                -ifqType       $val(ifq) \
                -ifqLen        $val(ifqlen) \
                -antType       $val(ant) \
                -propType      $val(prop) \
                -phyType       $val(netif) \
                -channel       $chan \
                -topoInstance  $topo \
                -agentTrace    ON \
                -routerTrace   ON \
                -macTrace      ON \
                -movementTrace ON

#===================================
#        Nodes Definition        
#===================================
#Create 14 nodes
set n0 [$ns node]
$n0 set X_ 329
$n0 set Y_ 232
$n0 set Z_ 0.0
$ns initial_node_pos $n0 20
set n1 [$ns node]
$n1 set X_ 250
$n1 set Y_ 317
$n1 set Z_ 0.0
$ns initial_node_pos $n1 20
set n2 [$ns node]
$n2 set X_ 389
$n2 set Y_ 316
$n2 set Z_ 0.0
$ns initial_node_pos $n2 20
set n3 [$ns node]
$n3 set X_ 436
$n3 set Y_ 159
$n3 set Z_ 0.0
$ns initial_node_pos $n3 20
set n4 [$ns node]
$n4 set X_ 312
$n4 set Y_ 128
$n4 set Z_ 0.0
$ns initial_node_pos $n4 20
set n5 [$ns node]
$n5 set X_ 208
$n5 set Y_ 202
$n5 set Z_ 0.0
$ns initial_node_pos $n5 20
set n6 [$ns node]
$n6 set X_ 1045
$n6 set Y_ 256
$n6 set Z_ 0.0
$ns initial_node_pos $n6 20
set n7 [$ns node]
$n7 set X_ 904
$n7 set Y_ 312
$n7 set Z_ 0.0
$ns initial_node_pos $n7 20
set n8 [$ns node]
$n8 set X_ 1066
$n8 set Y_ 351
$n8 set Z_ 0.0
$ns initial_node_pos $n8 20
set n9 [$ns node]
$n9 set X_ 1164
$n9 set Y_ 252
$n9 set Z_ 0.0
$ns initial_node_pos $n9 20
set n10 [$ns node]
$n10 set X_ 1112
$n10 set Y_ 137
$n10 set Z_ 0.0
$ns initial_node_pos $n10 20
set n11 [$ns node]
$n11 set X_ 966
$n11 set Y_ 155
$n11 set Z_ 0.0
$ns initial_node_pos $n11 20
set n12 [$ns node]
$n12 set X_ 636
$n12 set Y_ 482
$n12 set Z_ 0.0
$ns initial_node_pos $n12 20
set n13 [$ns node]
$n13 set X_ 820
$n13 set Y_ 221
$n13 set Z_ 0.0
$ns initial_node_pos $n13 20

#===================================
#        Generate movement          
#===================================
$ns at 0 " $n12 setdest 620 437 10 "
$ns at 1 " $n12 setdest 548 400 10 "
$ns at 2 " $n12 setdest 578 296 10 "
$ns at 3 " $n12 setdest 725 469 10 "
$ns at 4 " $n12 setdest 793 301 10 "
$ns at 5 " $n12 setdest 818 257 10 "
$ns at 0 " $n13 setdest 680 73 10 "
$ns at 1 " $n13 setdest 570 231 10 "
$ns at 2 " $n13 setdest 786 71 10 "
$ns at 3 " $n13 setdest 779 209 10 "
$ns at 4 " $n13 setdest 820 221 10 "

#===================================
#        Agents Definition        
#===================================
#Setup a TCP connection
set tcp0 [new Agent/TCP]
$ns attach-agent $n1 $tcp0
set sink10 [new Agent/TCPSink]
$ns attach-agent $n0 $sink10
$ns connect $tcp0 $sink10
$tcp0 set packetSize_ 1500

#Setup a TCP connection
set tcp1 [new Agent/TCP]
$ns attach-agent $n2 $tcp1
set sink11 [new Agent/TCPSink]
$ns attach-agent $n0 $sink11
$ns connect $tcp1 $sink11
$tcp1 set packetSize_ 1500

#Setup a TCP connection
set tcp2 [new Agent/TCP]
$ns attach-agent $n3 $tcp2
set sink12 [new Agent/TCPSink]
$ns attach-agent $n0 $sink12
$ns connect $tcp2 $sink12
$tcp2 set packetSize_ 1500

#Setup a TCP connection
set tcp3 [new Agent/TCP]
$ns attach-agent $n4 $tcp3
set sink13 [new Agent/TCPSink]
$ns attach-agent $n0 $sink13
$ns connect $tcp3 $sink13
$tcp3 set packetSize_ 1500

#Setup a TCP connection
set tcp4 [new Agent/TCP]
$ns attach-agent $n5 $tcp4
set sink14 [new Agent/TCPSink]
$ns attach-agent $n0 $sink14
$ns connect $tcp4 $sink14
$tcp4 set packetSize_ 1500

#Setup a TCP connection
set tcp5 [new Agent/TCP]
$ns attach-agent $n7 $tcp5
set sink15 [new Agent/TCPSink]
$ns attach-agent $n6 $sink15
$ns connect $tcp5 $sink15
$tcp5 set packetSize_ 1500

#Setup a TCP connection
set tcp6 [new Agent/TCP]
$ns attach-agent $n8 $tcp6
set sink16 [new Agent/TCPSink]
$ns attach-agent $n6 $sink16
$ns connect $tcp6 $sink16
$tcp6 set packetSize_ 1500

#Setup a TCP connection
set tcp7 [new Agent/TCP]
$ns attach-agent $n9 $tcp7
set sink17 [new Agent/TCPSink]
$ns attach-agent $n6 $sink17
$ns connect $tcp7 $sink17
$tcp7 set packetSize_ 1500

#Setup a TCP connection
set tcp8 [new Agent/TCP]
$ns attach-agent $n10 $tcp8
set sink18 [new Agent/TCPSink]
$ns attach-agent $n6 $sink18
$ns connect $tcp8 $sink18
$tcp8 set packetSize_ 1500

#Setup a TCP connection
set tcp9 [new Agent/TCP]
$ns attach-agent $n11 $tcp9
set sink19 [new Agent/TCPSink]
$ns attach-agent $n6 $sink19
$ns connect $tcp9 $sink19
$tcp9 set packetSize_ 1500


#===================================
#        Applications Definition        
#===================================
#Setup a FTP Application over TCP connection
set ftp0 [new Application/FTP]
$ftp0 attach-agent $tcp0
$ns at 1.0 "$ftp0 start"
$ns at 2.0 "$ftp0 stop"

#Setup a FTP Application over TCP connection
set ftp1 [new Application/FTP]
$ftp1 attach-agent $tcp1
$ns at 1.0 "$ftp1 start"
$ns at 2.0 "$ftp1 stop"

#Setup a FTP Application over TCP connection
set ftp2 [new Application/FTP]
$ftp2 attach-agent $tcp2
$ns at 1.0 "$ftp2 start"
$ns at 2.0 "$ftp2 stop"

#Setup a FTP Application over TCP connection
set ftp3 [new Application/FTP]
$ftp3 attach-agent $tcp3
$ns at 1.0 "$ftp3 start"
$ns at 2.0 "$ftp3 stop"

#Setup a FTP Application over TCP connection
set ftp4 [new Application/FTP]
$ftp4 attach-agent $tcp4
$ns at 1.0 "$ftp4 start"
$ns at 2.0 "$ftp4 stop"

#Setup a FTP Application over TCP connection
set ftp5 [new Application/FTP]
$ftp5 attach-agent $tcp5
$ns at 1.0 "$ftp5 start"
$ns at 2.0 "$ftp5 stop"

#Setup a FTP Application over TCP connection
set ftp6 [new Application/FTP]
$ftp6 attach-agent $tcp6
$ns at 1.0 "$ftp6 start"
$ns at 2.0 "$ftp6 stop"

#Setup a FTP Application over TCP connection
set ftp7 [new Application/FTP]
$ftp7 attach-agent $tcp7
$ns at 1.0 "$ftp7 start"
$ns at 2.0 "$ftp7 stop"

#Setup a FTP Application over TCP connection
set ftp8 [new Application/FTP]
$ftp8 attach-agent $tcp8
$ns at 1.0 "$ftp8 start"
$ns at 2.0 "$ftp8 stop"

#Setup a FTP Application over TCP connection
set ftp9 [new Application/FTP]
$ftp9 attach-agent $tcp9
$ns at 1.0 "$ftp9 start"
$ns at 2.0 "$ftp9 stop"


#===================================
#        Termination        
#===================================
#Define a 'finish' procedure
proc finish {} {
    global ns tracefile namfile
    $ns flush-trace
    close $tracefile
    close $namfile
    exec nam out.nam &
    exit 0
}
for {set i 0} {$i < $val(nn) } { incr i } {
    $ns at $val(stop) "\$n$i reset"
}
$ns at $val(stop) "$ns nam-end-wireless $val(stop)"
$ns at $val(stop) "finish"
$ns at $val(stop) "puts \"done\" ; $ns halt"
$ns run

# This script is created by NSG2 beta1
# <http://wushoupong.googlepages.com/nsg>

#===================================
#     Simulation parameters setup
#===================================
set val(chan)   Channel/WirelessChannel    ;# channel type
set val(prop)   Propagation/TwoRayGround   ;# radio-propagation model
set val(netif)  Phy/WirelessPhy            ;# network interface type
set val(mac)    Mac/802_11                 ;# MAC type
set val(ifq)    Queue/DropTail/PriQueue    ;# interface queue type
set val(ll)     LL                         ;# link layer type
set val(ant)    Antenna/OmniAntenna        ;# antenna model
set val(ifqlen) 50                         ;# max packet in ifq
set val(nn)     11                         ;# number of mobilenodes
set val(rp)     DSDV                       ;# routing protocol
set val(x)      1735                      ;# X dimension of topography
set val(y)      416                      ;# Y dimension of topography
set val(stop)   10.0                         ;# time of simulation end

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
#Create 11 nodes
set n0 [$ns node]
$n0 set X_ 275
$n0 set Y_ 260
$n0 set Z_ 0.0
$ns initial_node_pos $n0 20
set n1 [$ns node]
$n1 set X_ 194
$n1 set Y_ 337
$n1 set Z_ 0.0
$ns initial_node_pos $n1 20
set n2 [$ns node]
$n2 set X_ 423
$n2 set Y_ 336
$n2 set Z_ 0.0
$ns initial_node_pos $n2 20
set n3 [$ns node]
$n3 set X_ 357
$n3 set Y_ 147
$n3 set Z_ 0.0
$ns initial_node_pos $n3 20
set n4 [$ns node]
$n4 set X_ 214
$n4 set Y_ 161
$n4 set Z_ 0.0
$ns initial_node_pos $n4 20
set n5 [$ns node]
$n5 set X_ 827
$n5 set Y_ 211
$n5 set Z_ 0.0
$ns initial_node_pos $n5 20
set n6 [$ns node]
$n6 set X_ 1008
$n6 set Y_ 245
$n6 set Z_ 0.0
$ns initial_node_pos $n6 20
set n7 [$ns node]
$n7 set X_ 1356
$n7 set Y_ 239
$n7 set Z_ 0.0
$ns initial_node_pos $n7 20
set n8 [$ns node]
$n8 set X_ 1297
$n8 set Y_ 364
$n8 set Z_ 0.0
$ns initial_node_pos $n8 20
set n9 [$ns node]
$n9 set X_ 1390
$n9 set Y_ 312
$n9 set Z_ 0.0
$ns initial_node_pos $n9 20
set n10 [$ns node]
$n10 set X_ 1279
$n10 set Y_ 265
$n10 set Z_ 0.0
$ns initial_node_pos $n10 20

#===================================
#        Generate movement          
#===================================
$ns at 0 " $n5 setdest 797 247 10 " 
$ns at 2 " $n5 setdest 594 196 10 " 
$ns at 4 " $n5 setdest 532 81 20 " 
$ns at 6 " $n5 setdest 943 215 20 " 
$ns at 8 " $n5 setdest 827 211 20 " 
$ns at 0 " $n6 setdest 1082 154 10 " 
$ns at 2 " $n6 setdest 1103 316 20 " 
$ns at 4 " $n6 setdest 1008 245 20 " 

#===================================
#        Agents Definition        
#===================================
#Setup a TCP connection
set tcp0 [new Agent/TCP]
$ns attach-agent $n1 $tcp0
set sink4 [new Agent/TCPSink]
$ns attach-agent $n0 $sink4
$ns connect $tcp0 $sink4
$tcp0 set packetSize_ 1500

#Setup a TCP connection
set tcp1 [new Agent/TCP]
$ns attach-agent $n2 $tcp1
set sink5 [new Agent/TCPSink]
$ns attach-agent $n0 $sink5
$ns connect $tcp1 $sink5
$tcp1 set packetSize_ 1500

#Setup a TCP connection
set tcp2 [new Agent/TCP]
$ns attach-agent $n3 $tcp2
set sink6 [new Agent/TCPSink]
$ns attach-agent $n0 $sink6
$ns connect $tcp2 $sink6
$tcp2 set packetSize_ 1500

#Setup a TCP connection
set tcp3 [new Agent/TCP]
$ns attach-agent $n4 $tcp3
set sink7 [new Agent/TCPSink]
$ns attach-agent $n0 $sink7
$ns connect $tcp3 $sink7
$tcp3 set packetSize_ 1500

#Setup a TCP connection
set tcp9 [new Agent/TCP]
$ns attach-agent $n5 $tcp9
set sink8 [new Agent/TCPSink]
$ns attach-agent $n0 $sink8
$ns connect $tcp9 $sink8
$tcp9 set packetSize_ 1500

#Setup a TCP connection
set tcp11 [new Agent/TCP]
$ns attach-agent $n6 $tcp11
set sink10 [new Agent/TCPSink]
$ns attach-agent $n5 $sink10
$ns connect $tcp11 $sink10
$tcp11 set packetSize_ 1500

#Setup a TCP connection
set tcp13 [new Agent/TCP]
$ns attach-agent $n8 $tcp13
set sink18 [new Agent/TCPSink]
$ns attach-agent $n10 $sink18
$ns connect $tcp13 $sink18
$tcp13 set packetSize_ 1500

#Setup a TCP connection
set tcp14 [new Agent/TCP]
$ns attach-agent $n9 $tcp14
set sink19 [new Agent/TCPSink]
$ns attach-agent $n10 $sink19
$ns connect $tcp14 $sink19
$tcp14 set packetSize_ 1500

#Setup a TCP connection
set tcp15 [new Agent/TCP]
$ns attach-agent $n7 $tcp15
set sink20 [new Agent/TCPSink]
$ns attach-agent $n10 $sink20
$ns connect $tcp15 $sink20
$tcp15 set packetSize_ 1500

#Setup a TCP connection
set tcp16 [new Agent/TCP]
$ns attach-agent $n6 $tcp16
set sink17 [new Agent/TCPSink]
$ns attach-agent $n10 $sink17
$ns connect $tcp16 $sink17
$tcp16 set packetSize_ 1500


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
$ftp4 attach-agent $tcp9
$ns at 1.0 "$ftp4 start"
$ns at 2.0 "$ftp4 stop"

#Setup a FTP Application over TCP connection
set ftp5 [new Application/FTP]
$ftp5 attach-agent $tcp11
$ns at 1.0 "$ftp5 start"
$ns at 2.0 "$ftp5 stop"

#Setup a FTP Application over TCP connection
set ftp6 [new Application/FTP]
$ftp6 attach-agent $tcp13
$ns at 1.0 "$ftp6 start"
$ns at 2.0 "$ftp6 stop"

#Setup a FTP Application over TCP connection
set ftp7 [new Application/FTP]
$ftp7 attach-agent $tcp14
$ns at 1.0 "$ftp7 start"
$ns at 2.0 "$ftp7 stop"

#Setup a FTP Application over TCP connection
set ftp8 [new Application/FTP]
$ftp8 attach-agent $tcp16
$ns at 1.0 "$ftp8 start"
$ns at 2.0 "$ftp8 stop"

#Setup a FTP Application over TCP connection
set ftp9 [new Application/FTP]
$ftp9 attach-agent $tcp15
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


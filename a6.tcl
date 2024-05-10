set ns [new Simulator]
set nf [open out.nam w]
$ns namtrace-all $nf

proc finish { } {
global ns nf

$ns flush-trace
close $nf
exec nam out.nam &
exit 0
}


set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]
set n4 [$ns node]

$n0 color "blue"
$n1 color "pink"
$n2 color "yellow"
$n3 color "red"
$n4 color "orange"

$ns duplex-link $n0 $n1 1Mb 10ms DropTail
$ns duplex-link $n0 $n2 1Mb 10ms DropTail
$ns duplex-link $n0 $n3 1Mb 10ms DropTail
$ns duplex-link $n1 $n2 1Mb 10ms DropTail
$ns duplex-link $n1 $n3 1Mb 10ms DropTail
$ns duplex-link $n2 $n3 1Mb 10ms DropTail
$ns duplex-link $n4 $n3 1Mb 10ms DropTail
$ns duplex-link $n4 $n2 1Mb 10ms DropTail

$ns at 5.0 "finish"

$ns run

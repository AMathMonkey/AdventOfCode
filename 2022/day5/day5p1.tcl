set lines [split [read [open input.txt]] \n]

foreach line $lines {
    if {[string match {*\[*} $line]} {incr initLines; continue}
    set numStacks [lindex [lsearch -inline -all $line {*?*}] end]
    break
}

for {set i 0} {$i < $numStacks} {incr i} {
    lappend stacks [list]
}

foreach line [lrange $lines 0 $initLines-1] {
    set letters [list]
    for {set i 1} {$i < [string length $line]} {incr i 4} {
        lappend letters [string index $line $i]
    }
    for {set i 0} {$i < [llength $letters]} {incr i} {
        set letter [lindex $letters $i]
        if {$letter ne " "} {lset stacks $i end+1 $letter}
    }
}

foreach line [lrange $lines $initLines+2 end] {
    regexp {move (\d+) from (\d+) to (\d+)} $line _ num src dest
    for {set i 0} {$i < $num} {incr i} {
        set srcStack [lindex $stacks $src-1]
        set destStack [lindex $stacks $dest-1]
        set popped [lindex $srcStack 0]
        lset stacks $src-1 [lreplace $srcStack 0 0]
        lset stacks $dest-1 [linsert $destStack 0 $popped]
    }
}

foreach stack $stacks {
    puts -nonewline [lindex $stack 0]
}
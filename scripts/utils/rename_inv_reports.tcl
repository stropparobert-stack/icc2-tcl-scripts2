# scripts/utils/rename_inv_reports.tcl
# Purpose: Rename *.rpt containing "INV" to *_checked.rpt under ${ROOT}/reports

proc rename_inv_reports {} {
    if {![info exists ::env(ICC2_WS)]} {
        puts "ERROR: env ICC2_WS is not set."
        return -code error
    }

    set root   [file normalize $::env(ICC2_WS)]
    set rptdir [file normalize [file join $root reports]]
    set files  [glob -nocomplain [file join $rptdir *.rpt]]

    if {[llength $files] == 0} {
        puts "Warning: no .rpt under $rptdir"
        return
    }

    set n 0
    foreach f $files {
        set fname [file tail $f]
        if {[string match "*INV*" $fname]} {
            set newf [file normalize "[file rootname $f]_checked.rpt"]
            if {[catch {file rename -force $f $newf} err]} {
                puts "Warning: rename failed for $fname -> $err"
            } else {
                incr n
                puts "Renamed: $fname -> [file tail $newf]"
            }
        }
    }
    puts "Done. Renamed $n file(s)."
}

rename_inv_reports

proc report_unclocked {args} {
    set procargs(-verbose) false
    parse_proc_arguments -args $args procargs
    set verbose $procargs（-verbose)
 
    set all_clock_pins [all_registers -clock_pins]
    if {$::synopsys_program_name == "pt_shell"} {
        set unclocked [filter_collection $all_clock_pins "defined(clocks)"]
        set unclocked [remove_from_collection $all_clock_pins $unclocked]
        set constant {Logic([01])/output}
    } else {
        set unclocked [filter_collection $all_clock_pins is_on_clock_network==false"]
        set constant {\*\*logic_([01])\*\*}
    }
    
    array unset uc_roots
    set uc_roots(LOGIC_0) {}
    set uc_roots(LOGIC_1) {}
    set c_root ""


    foreach_in_collection uc $unclocked {
        redirect -varible redir { set c_root [get_object_name [all_fanin -flat -startpoints_only -to $UC -trace_arcs all]] }
        if {$::synopsys_program_name == "icc_shell" && $c_cool==""} {
            #ICC doesn't set c_root if it is a tie0/1
            set c_root $redir
        } else {
            # behavior change starting with version 2015.06
            regexp {(\d{4})\.(\d{2})} $::sh_product_version m v1 v2
            set version "$v1$v2"
            if {$version < 201506} {
                if {[regexp $constant $c_root m s} {
                    set c_root "LOGIC_$s"
                }
            } else {
                if {[get_object_name $uc] == $c_root} {
                    set s [get_attribute $uc constant_value]
                    if {$s == "0" || $s == "1"} {
                        set c_root "LOGIC_$s"
                    }
                }
            }
            lappend uc_root($c_root) [get_object_name $uc]
        }



    }
    echo "List of clock drives and number of unclocked clock pins in their fanout:\n"

    #Sort the list and put LOGIC_0 and LOGIC_1 at the end
    set all_roots [concat [lminus [lsort [array names uc_root]] {LOGIC_0 LOGIC_1}] {LOGIC_0 LOGIC_1}]
    foreach c_root $all_root {
        echo [format %-50s    %d $c_roor [llength $uc_roots($c_root)]]
        if {$verbose} {
            foreach pin $uc_roots($c_root) {
                echo "    $pin"
            }
        }
    }
}


define_proc_attributes report_unclocked \
    -info "Report unclocked registers" \
    -define_args {
    {-verbose "Be verbose." "" boolean optional}

}

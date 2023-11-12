
proc spt_set_link_db {args} {
    parse_proc_arguments -args $args results
    
    upvar search_path      search_path
    upvar link_library     link_library
    upvar target_library   target_library 
    upvar db_dir           db_dir
    set   aocv_flag        ""

    if {$::synopsys_program_name=="pt_shell"} {
        if {[info exists :: aocv_enable]} {
            if {$::aocv_flag ==1} {
                set aocv_flag 1
                upvar aocv_files aocv_files
            }
        }
    }

    if {![info exists db_dir]} {
        set db_dir
    }

    if {[info exists results(-db_dir)]} {
        set db_dir [spt_list2line $results(-db_dir)]
    }

    #corner
    if {[info exits results(-corner)]} {
        set corner $results(-corner)
    } elseif {[info exits :: $CORNER}]} {
        set corner $::CORNER
    } else {
        exit
    }
   
    #lib_format
    #ratget_lib
    if {$::synopsys_program_name=="dc_shell"} && [info exits :: target_lib] {
        set results(target_lib_name) $::target_lib
    }
}

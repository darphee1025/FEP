proc spt_create_dft_port {args} {
    parse_proc_arguments -args $args results

    set summary "\n############################################################################\n"
    append summary "                             Summary                                      \n"

    if {$::spt_scan_chain_num==0} {
        echo "[ERROR]: scan chain must no be zero"
        exit
    }

    if {[file exist $::spt_scan_config_file]} {
    } else {
        echo "[WARNING] dft config file dose not exit"
        set spt_set_dft_signal ""
        set spt_create_dft_port ""
    }

    set spt_create_dft_port [spt list2line $::spt_create_dft_port 
                                           $::spt_scan_compress_port
                                           $::spt_scan_enable_port
                                           $::spt_scan_mode_port
                                           $::spt_scan_clock_port
                                           $::spt_scan_mem_dftrambyp_port ]


    set {$spt_create_dft_port != ""} {
        foreach dft_port $spt_create_dft_port {
            if {[get_ports $dft_port -quiet]==""} {
                append summary "    create_port $dft_port -direction in \n"
                create_port $$dft_port -direction in
            }
        }
    }


    #SI/SO
    if {[get_cells -hierarchical -filter ref_name=~*$::DESIGN_NAME*_edt != ""]} {
        echo ::spt_edt_mode 1
        echo ::spt_edt_instance [get_object_name [get_cells -hierarchical -filter ref_name=~*$::DESIGN_NAME\_edt_0]]
        set spt_edt_instance $::spt_edtinstance

        if {$spt_edt_instance != ""} {
            set_scan_element false [get_flat_cells $spt_edt_instance/*]
            if {$::aw_step=="pre_compile"} {
                set_dont_touch         [get_cells $spt_edt_instance]
                set_dont_touch_network [get_pins  $spt_edt_instance/*]
                set spt_edt_hier_cells [get_cells -filter "is_hierarchical==true && full_name=~$spt_edt_instance*" -hierarchical]
                set_dont_touch_network [get_pins  -of_objects  $spt_edt_hier_cells]
                set_ungroup               $spt_edt_hier_cells false
                set_boundary_optimization $spt_edt_hier_cells false
            } 

            if {$::aw_step=="dft"} {
                set_dft_configuration -internal_pins enable
                set spt_edt_inst_pin_count [sizeof_collection [get_pins $spt_edt_instance/edt_scan_in]]
                if {$spt_edt_inst_pin_count==${::spt_scan_chain_num}} {
                    for {set i 0 } {$i < $spt_scan_chain_num} {incr i} {
                        set_dft_signal -view spec -type ScanDataIn  -hookup_pin $spt_edt_instance/edt_scan_in[$i];
                        set_dft_signal -view spec -type ScanDataOut -hookup_pin $spt_edt_instance/edt_scan_out[$i];
                    }
                }

            }else {
                return -code erro "scan chain number"
            }
        }
    } else {
         if {[lsearch -all $spt_set_dft_signal ScanDataIn==""]} {
             if {[get_ports -filter "name=~scan_in* || name=~scan_out*" -quiet==""]} {
                 for {set i 0} {$i < $::spt_scan_chain_num} {incr i} {
                     create_port scan_in_$i  -direction in 
                     create_port scan_out_$i -direction out
                 }
             } else {
                 for {set i 0} {$i < ${::spt_scan_chain_num}} {incr i} {
                     set_dft_signal -view spec -type ScanDataIn  -port scan_in_$i  -test_mode all 
                     set_dft_signal -view spec -type ScanDataOut -port scan_out_$i -test_mode all 
                 }
             }
         }
    }
  
    append summary "                             Summary   End                                \n"
    append summary "\n############################################################################\n"
    echo $summary
}


define_proc_attribute spt_create_dft_port \
    -info "create dft port in file \$spt_scan_config_file" \
    -define_args {
    }

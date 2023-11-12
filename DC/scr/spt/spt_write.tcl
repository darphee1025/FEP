proc spt_write {args} {
    parse_proc_arguments -args $args results
    
    set all_step "
        pre_compile
        compile1
        compile2
        dft
        dft_compile
        optimize_netlist
    "

    if {[lsearch $all_step $results(-step)]==-1} {
        echo "Error: no step match"
        return
    }
    
    if {$result(-step)=="$::spt_end_step" && $:spt_write_to_pub==1} {
        set results(-write_to_file_pub_dir)
    }

    #output dir 
    if {[info exists results(-dir)]} {
        set dc_rpt_dir $results(-dir)
    } elseif {[info exists results(-step)]} {
        set dc_rpt_dir ./data/$results(-step)
    } elseif {[info exists ::spt_data_dir]} {
        set dc_rpt_dir $::spt_data_dir
    }
  
    file mkdir $dc_rpt_dir 

    #ddc verilog sdc for all steps
    set top_design [current_design_name]
    if {![info exists results(-only_write_to_file_pub_dir)]} {
        if {$results(-step)!="pre_compile"} {
            define_name_rules verilog -reset -special verilog -allowed "a-z A-Z 0-9 _" -first_restricted "0-9_\[\] \\"
            change_names -rule verilog -hierarchy
            write -output $dc_rpt_dir/${top_design}.v -format verilog -hierarchy
        }
        
        #def 
        if {[shell_is_in_topographical_model] && $results(-step)=="pre_compile" && $rersults(-step)!="dft"} {
            write_def -components -output $dc_rpt_dir/${top_design}.def
            report_congestion -build_map
        }

        write -output $dc_rpt_dir/${top_design}.ddc -format ddc -heirarchy 
        write_sdc -nosplit $dc_rpt_dir/${top_design}.sdc
    
        if {[all_level_shifts]!="" || [all_isolation_cells!=""]} {
            save_upf $dc_rpt_dir/${top_design}.upf
        }

        #ctl ctlddc spf def fot dft* step
        if {[regexp {^dft} $results(-step)] || $results(-step)=="optimize_netlist"} {
            write_test_model -format ctl -output $dc_rpt_dir/${top_design}.tcl
            write_test_model -format ddc -output $dc_rpt_dit/${top_design}.ctlddc 
   
            if {$::spt_scan_compress_port==""} {
                write_test_protocol -test_mode -output $dc_rpt_dir/${top_design}.spf
            } else {
                write_test_protocol -test_mode $::spt_scan_base_mode_name -name verilog \
                                    -output    $dc_rpt_dir/${top_design}_base_mode.spf
                write_test_protocol -test_mode $::spt_scan_compress_mode_name -name verilog \
                                    -output    $dc_rpt_dir/${top_design}_compress_mode.spf
            }
 
            write_scan_def -output $dc_rpt_dir/${top_design}_scan.def
        }
    }
}

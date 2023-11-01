proc spt_set_multi_vth_group {aptgs} {
    parse_proc_arguments -arg $args results;
    
    redirect -variable lib_list {list_libs}

    foreach lib [get_object_name [get_libs -filter "name!~*sldb && name!= gtech]]" {

        eval regexp {$lib\\s+\\S+\\s+(\\S)}} \$lib_lists match lib_path
	set pub_lib_name [file tail [file dirname $lib_path ]]
	set_attribute -type string [get_libs $lib] default_threshold_voltage_group $pub_lib_name 
	echo "cccccccccccccc $pub_lib_name"
    }
    
    set all_lib [lsort $::link_lib_name]
    set lvt_lib [lsearch -all inline $all_lib *pkl*]
    set svt_lib [lsearch -all inline $all_lib *pks*]
    set hvt_lib [lsearch -all inline $all_lib *pkh*]

    if {$lvt_lib != ""} {
        set ::spt_lvth_group [lindex $lvt_lib 0]
    }

    if {$svt_lib != ""} {
        set ::spt_lvth_group [lindex $svt_lib 0]
    }

    if {$hvt_lib != ""} {
        set ::spt_lvth_group [lindex $hvt_lib 0]
    }

}

define_proc_attributes spt_multi_vth_group \
    -info "aaaaa" \
    -define_args {
        {-verbose "verbose" "" boolean optional }
    }



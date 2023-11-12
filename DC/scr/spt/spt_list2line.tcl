proc spt_list2line {args} {

    redirect -variable log_info {sizeof_collection $args}
    if {[regexp { 
}

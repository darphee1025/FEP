echo {}

proc find_float_pins {args} {
    
    set results(-include_hier_cell_pins)   0

    parse_proc_arguments -args $args results
    set include_hier_cell_pins $results(-include_hier_cell_pins)
   
    if {!include_hier_cell_pins} {
        set cells [get_cells -hier -filter !is_hierarchical] 
    } else {
        set cells [get_cells -hier] 
    }
    set pins [get_pins -of_objects $cells]
    set pins_wo_nets [filter_col $pins undefined(net)&&undefined(case_value)]
    echo "INFO: checked [sizeof pins] pins...found [sizeof $pins_wo_nets] floating pins"
    return $pins_wo_nets
}


define_proc_attributes find_float_pins   \
    -info "fond floating pins in design" \
    -define_args \
    {
        {-include_hier_cell_pins "includes pins from hierarical cells" "" boolean optional}
}

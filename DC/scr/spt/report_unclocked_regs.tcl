proc report_unclocked_reg {} {
    set no_clock_reg [all_registers]
    
    foreach_in_collection clk [all_clocks] {
        set no_clock_reg [remove_from_collection $no_clock_reg [all_regosters -clock $clk]]
    }

    foreach_in_collection item $no_clock_reg {
        puts $item
    }

}

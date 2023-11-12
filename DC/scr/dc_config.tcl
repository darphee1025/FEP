#############################################################################
# dc_config.tcl
#############################################################################


#ICG Configuration
set cfg_icg_fanout                  64
set cfg_icg_setup                   0.2
set cfg_icg_hold                    0.0
set cfg_icg_min_bitwidth            3
set cfg_icg_exclude_cells           {}
set cfg_icg_group                   0

set cfg_congestion_effort_high      0
set cfg_use_multibit                0
set cfg_cost_priority               {max_delay}
set cfg_max_uncertainty             0.15
set cfg_critical_range              "" 
set cfg_enable_auto_weight          0
set cfg_max_fanout                  64
set cfg_remove_bound                0
set cfg_out_insert_buffer           1

set cfg_leakage_opt                 1
set cfg_lvt_percentage              0
set cfg_estimiate_clock_power       1


#formal
set cfg_verification_high_design    ""
set cfg_compile_command             ""
set cfg_chip_level                  $CHIP_LEVEL

#DFT Configuration
set cfg_scan_chain_num              2
set cfg_scan_exclude_cell           {}
set cfg_scan_icg_exclude            {}
set cfg_not_insert_dft              0
set cfg_read_sub_block_rtl          0

set cfg_scan_mode_port              ""
set cfg_scan_mode_port_hookup_pin   ""
set cfg_scan_mode_active_state      "1"

set cfg_scan_enable_port            "x_dft/scan_en"
set cfg_scan_enable_port_hookup_pin ""
set cfg_scan_enable_active_state    "1"

set cfg_scan_active_low_reset_port  ""
set cfg_scan_active_high_reset_port ""

set cfg_scan_active_low_constant_port   ""
set cfg_scan_active_high_constant_port  ""

set cfg_scan_test_assume_low_port       ""
set cfg_scan_test_assume_high_port      ""

set cfg_scan_mem_dftrambyp_port         ""
set cfg_scan_mem_dftrambyp_pin          ""
set cfg_scan_mem_dftrambyp_hookup_pin   ""
set cfg_scan_mem_dftrambyp_act_state    ""

set cfg_scan_config_file                "../scr/dft_config.tcl"

set cfg_scan_compress_port              ""
set cfg_scan_compress_port_hookup_pin   ""
set cfg_scan_compress_port_value        ""

set cfg_scan_base_mode_name             "base_mode"
set cfg_scan_compress_mode_name         "compress_mode"

set cfg_scan_max_length                 "400"

set cfg_scan_compress_location          ""
set cfg_scan_compress_hybird            ""

#scan occ


#Operating Con
if {$FAB_TECH=="SMIC011_UHD_RVT"} {
    array set cfg_operating_conditions {
        ss "ss_v1p08_125c"
        tt ""
        ff ""
    }
        set cfg_dont_use_cells      ""
        set cfg_rc_ignored_layers   ""
        set cfg_min_routing_layer   ""
        set cfg_man_routing_layer   ""
        set cfg_driving_cell        "BUFUHDV6"
        set cfg_icg_cell            "CLKLANQV2_7TV50"
        set cfg_icgn_name           ""
        set cfg_memory_path         ""
        set cfg_tiecell_pattern     ""

} elseif {$FAB_TECH=="SMIC018_UHD_RVT"} {
    array set cfg_operating_conditions {
        ss "ss_v1p08_125c"
        tt ""
        ff ""
    }
        set cfg_dont_use_cells      ""
        set cfg_rc_ignored_layers   ""
        set cfg_min_routing_layer   ""
        set cfg_man_routing_layer   ""
        set cfg_driving_cell        "BUFUHDV6"
        set cfg_icg_cell            "CLKLANQV2_7TV50"
        set cfg_icgn_name           ""
        set cfg_memory_path         ""
        set cfg_tiecell_pattern     ""
} else {
    $echo "Invalid FAB_TECH"
    exit
}


if {$::synopsys_program_name=="dc_shell"} {
    #aw_auto_set_driving_icg_cell
}







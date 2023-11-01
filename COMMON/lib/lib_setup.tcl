#######################################################
#lib_setup.tcl
#######################################################
if{$FAB_TECH=="SMIC011_UHD_RVT"} {
    source -echo -verbose ../../COMMMON/lib/smic_011um_uhd_rvt.tcl
} elseif {$FAB_TECH=="SMIC018_3EBCD_UHD50_RVT"} {
    source -echo -verbose ../../COMMMON/lib/smic_018um_3ebcd_uhd50_rvt.tcl
} else {
    echo "Invalid VENDOR"
    exit
}

source  -echo -verbose ../../COMMON/lib/prj/${PRJ_NAME}_lib.tcl



set ALL_LIBS "$FAB_LIBS $PRJ_LIBS"

if{$::synopsys_program_name=="dc_shell"} {
    set_app_var_target_library  $ALL_LIBS
    set_app_var link_library  "*  $ALL_LIBS dw_foundation.sldb"
}

if{$::synopsys_program_name=="pt_shell"} {
    set_app_var link_path "*  $ALL_LIBS "
}


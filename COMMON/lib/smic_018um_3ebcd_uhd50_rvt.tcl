#######################################################
#lib_setup.tcl
#######################################################


set atpg_std_rvt "/misc/tech/PDK_OA/*.atpg"

#standary cells
if{${CORNER}=="ss"}{
    set lib_std_rvt "misc/tech/PDK_OA/SMIC/scc018v33bcd_uhd50_rvt_ss_v4p5_125_ccs.db"
} elseif {${CORNER}=="tt"}{
    set lib_std_rvt "misc/tech/PDK_OA/SMIC/scc018v33bcd_uhd50_rvt_ss_v4p5_125_ccs.db"
} else {
    set lib_std_rvt "misc/tech/PDK_OA/SMIC/scc018v33bcd_uhd50_rvt_ss_v4p5_125_ccs.db"
}

set FAB_LIBS "$lib_std_rvt"
set ATPG_LIBS "$atpg_std_rvt"

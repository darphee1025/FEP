if{${CORNER}=="ss"}{
    set other_libs "misc/tech/PDK_OA/SMIC/scc018v33bcd_uhd50_rvt_ss_v4p5_125_ccs.db"
} elseif {${CORNER}=="tt"}{
    set other_libs "misc/tech/PDK_OA/SMIC/scc018v33bcd_uhd50_rvt_ss_v4p5_125_ccs.db"
} else {
    set other_libs "misc/tech/PDK_OA/SMIC/scc018v33bcd_uhd50_rvt_ss_v4p5_125_ccs.db"
}

set other_atpgs ""
set PRJ_LIBS  "$other_libs"

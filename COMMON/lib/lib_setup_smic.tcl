#######################################################
#lib_setup.tcl
#######################################################
#Srandard Cells
if{${CORNER}=="ss"}{
    set STD_LIB_RVT "misc/tech/PDK_OA/SMIC/scc018v33bcd_uhd50_rvt_ss_v4p5_125_ccs.db"
} elseif {${CORNER}=="TT"}{

}

#set STD_ATPG_SVT "/home/foundary/hlmc055pdk/std/hd/base/svt/2.02a/verilog/3.0/hu55npksdst.v"
#set PWR_ATPG_SVT "/home/foundary/hlmc055pdk/std/hd/pok/svt/2.02a/verilog/3.0/hu55npksdst.v"
#set SPT_PWR_ATPG "/home/"

#efuse

#if{{$CORNER}=="ss"} {
#    set EFUSE_LIBS "misc/tech/PDK_OA/SMIC/scc018v33bcd_uhd50_rvt_ss_v4p5_125_ccs.db"
#} elseif {${CORNER}== "tt"
#
#}
#
#
#set EFUSE_ATPG ""
#
#iopad
#if{{$CORNER}=="ss"} {
#    set IO_LIBS "misc/tech/PDK_OA/SMIC/scc018v33bcd_uhd50_rvt_ss_v4p5_125_ccs.db"
#} elseif {${CORNER}== "tt"
#
#}
#
#set IO_ATPG ""

#Other libs
source -echo -verbose ../../COMMON/lib/prj/${PRJ_NAME}_lib.tcl

set all_libs "\
             $STD_LIB_RVT  \
	     $other_libs \
	     "
set all_atpg "\
             $STD_ATPG_SVT \
	     $PWR_ATPG_SVT \
	     $SPT_PWR_ATPG_SVT \
	     $EFUSE_ATPG \
	     $IO_ATPG \
	     $other_atpg \
	     "

if{$::synopsys_program_name=="dc_shell"} {
    set_app_var_target_library  $ALL_LIBS
    set_app_var link_library  "*  $ALL_LIBS dw_foundation.sldb"
}

if{$::synopsys_program_name=="pt_shell"} {
    set_app_var link_path "*  $ALL_LIBS "
}


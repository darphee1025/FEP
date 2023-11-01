#######################################################
#config.tcl
#######################################################
#Design Configuration
set PRJ_NAME     "jwq40260"
set DESIGN_NAME  "dig_top"
set PRJ_DIR      "/home/kiss/darphee/jwq40260/jwq40260"
set HDL_DIR     "${PRJ_DIR}/hdl"

set rtl_dir      "${PRJ_DIR}/hdl"
set mod_dir      "${PRJ_DIR}/mod"

###########################spyglass####################
set EN_SGLIB         ""
set EN_SYSTEMVERILOG "1"
set LINT_RTL         "1"
###########################spyglass####################


set SDC_FILE     "../../COMMON/sdc/${PRJ_NAME}.sdc"
set UPF_FILE     "../../COMMON/upf/${PRJ_NAME}.upf"
set FILE_LIST    "../../COMMON/filelist/${PRJ_NAME}.f"

set NETLIST_PR   ""

set FAB_TECH     "SMIC018_3EBCD_UHD50_RVT"

set CORNER       "ss"
#set CORNER       "tt"
#set CORNER       "ff"

set USE_WIRE_LOAD "1"

set CHIP_LEVEL    "1"
set UPF_FLOW      ""; #1 or empty
set DFT_FLOW      ""; #1 or empty
set DFT_COMP      ""; #1 or empty
set ATPG_COMP     ""; #1 or empty

#######################################################
#ATPG
#######################################################
set ATPG_TRANS_FLOW    "" ; #1 or empty
set ATPG_STUCK_FLOW    "1" ; #1 or empty



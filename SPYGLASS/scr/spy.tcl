source ../config.tcl

new_project ${PRJ_NAME} -projectwdir [pwd] -force

set_option top ${DESIGN_NAME}


#read design
read_file -type sourcelist ../../COMMONfilelist/${PRJ_NAME}.f

if {$EN_SGLIB=="1"} {
    read_file -type sglib      { ../sglib/isrgr_e_generic_core_ss1p35v125c.sglib}
}

read_file -type sgdc       ../sgdc/${PRJ_NAME}.sgdc


#read_type -type awl
#set_option default_wavier_file

#setup
set_option language_mode mixed
set_option designread_disable_flatten yes

#set_option stop ${DESIGN_TOP}

set_option incdir $HDL_DIR


if {$EN_SYSTEMVERILOG=="1"} {
    set_option enableSV  yes
}

current_methodology  $SPYGLASS_HOME/GuideWare/latest/block/rtl_handoff

#lint rtl

if {$LINT_RTL=="1"} {
    current_goal lint/lint_rtl -top ${DESIGN_NAME}
}


save_project -force ${PRJ_NAME}.prj


exit -force

set_host_option -max_cores 6

##########################
#Step1
#Read Design
##########################

set_svf ../svf/${DESIGN_NAME}.svf

define_design_lib WORK -path ./WORK


analyze -format sverilog -vcs "-f $FILE_LIST"
elaborate ${DESIGN_NAME}
current_design ${DESIGN_NAME}
redirect ../rpt/link.rpt {link}
redirect ../rpt/check_design_pre.rpt {check_design}

write_file -output ../ddc/${DESIGN_NAME}_elab.ddc -format ddc -hierarchy

#exit



#upf

if {$UPF_FLOW==1} {
    load_upf ${UPF_FILE}
    #POWER
    set_VOLTAGE 2.97   -object_list   VCC
    set_VOLTAGE 2.97   -object_list   VCC_IO
    #GROUND
    set_VOLTAGE 0      -object_list   GND
    set_VOLTAGE 0      -object_list   GND_IO
}

##########################
#Step2
#Read Constraint
##########################
if{$DFT_FLOW==1} {
    

}

if {[shell_is_in_topographical_model]} {
    if {$cfg_estimate_clock_power==1}{
        set_power_prediction -ct_reference [get_lib_cells -quiet "*/"]
    }
}

##########################
#Step3
#1st Compile
##########################

if {$cfg_verification_high_design != ""} {
    set_verification_priority -high [get_cells $cfg_verification_high_design]
}



if {$cfg_compile_command==""} {
    set cfg_compile_cmd "compile ultra -scan -gate_clock -no_autoungroup -no_boundary_optimization"
    if {[shell_is_intopographical_mode]}{
        append ${cfg_compile_cmd "-spg"}
        if {$cfg_ahfs_route} {
            set_ahfs_options -constant_nets true -global_route true
        }else {
            set_ahfs_options -constant_nets true
        }
        report_ahfs_options > ../rpt/report_ahfs_options.rpt
    }
}else {
    set cfg_compile_cmd $cfg_compile_command 
}


eval $cfg_compile_cmd


##########################
#Step4
#2nd Compile
##########################

##########################
#Step5
#Insert DFT
##########################
if{$DFT_FLOW==1} {
    source -echo -verbose ../scr/dft.tcl
}

##########################
#Step6
#DFT compile
##########################
if {[shell_is_in_topographical_model]} {
    compile_ultra -scan -spg -incr
}else {
    compile_ultra -scan -incr
}

if {DFT_FLOW==1} {
    redirect ../rpt/report_test_assume_post.rpt {report_test_assume}
}


##########################
#Step7
#Optimization Netlist
##########################
optimize_netlist -area

define_name_rules verilog -reset -special verilog -allowed "a-zA-Z0-9" -first_restricted "0-9"
change_names_rules verilog -hierarchy -log_changes ../rpt/change_names2.rpt

##########################
#Step8
#Write OUT
##########################
redirect ../rpt/report_path_group.rpt {report_path_group}

grou_path -name reg2reg   -from  [all_registers -clock_pins]   -to [all_registers -data_pins]
grou_path -name in2reg    -from  [all_inputs]                  -to [all_registers -data_pins]
grou_path -name reg2out   -from  [all_registers -clock_pins]   -to [all_outputs]
grou_path -name in2out    -from  [all_inputs]                  -to [all_outputs]



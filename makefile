gen_filelist:
	./gen.filelist
spyglass:gen_filelist
	cd SPYGLASS/work && sg_shell -tcl ../scr/spy.tcl
spyglass_gui:spyglass
	cd SPYGLASS/work && spyglass -project jwq40260.prj& 
	

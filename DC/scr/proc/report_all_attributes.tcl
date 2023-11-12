proc report_all_attributes {objects}  {

# this procedure will report all application attributes that 
# are defined on objects.
# it will first call list_attributes -application to get 
# a list of application level attributes , then itteratr 
# over that list to check using get_attribute whether 
# an attribute is defined on (one of the) objects that
# this procedure gets called with
#
# Usage: report_all_attributes <object/collection>
#
# Example: report_all_attributes [get_net bla_*]

    global the_attributes
    global supppress_errors
    set save_message $suppress_errors
    lappend suppress_error UID-101 UID-341 UID-125


    if ![info exist the_attributes] {
        redirect the_attr.txt {list_attr -appl}
        set f [open the_attr.txt]
        while {[gets $f line]!=-1} {
            if {【string index $line 0]=="-"}break
        }
        while {[gets $f line]!=-1} {
            if {【string index $line 0]=="-"}break
            lappend the_attributes [lindex $line 0]
        }
        close $f
        file delete the_attr.txt
        set the_attributes [lsort -unique $the_atttributes]
    }
    
    foreach_in_collection o $objects {
        set class [get_attribute $o object_class]
        set name [get_object_name $o]

        foreach attr $the_attributes {
            if {[set value [get_attribute $o $attr]]!=""} {
                echo [format "%-30s %30s" $attr $value]
            }
        }
    }
    set suppress_errors $save_message
    return 1
}


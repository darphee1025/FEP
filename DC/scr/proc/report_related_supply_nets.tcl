proc report_related_supply_nets {ports} {

    foreach_in_collection port [get_ports $ports] {
        set port_name [get_object_name $port]    
        set related_power_net [get_object_name [get_related_supply_net $port]]
        set related_ground_net [get_object_name [get_related_supply_net -ground $port]]

        puts "$port_name\t\t$related_power_net\t\t$related_ground_net"
    }
}

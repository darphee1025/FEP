set dont_use_list     [list]

foreach item ${dont_use_list} {
    set_dont_use   [get_lib_cells hu55n*/${item}]
}

set remove_list  [list]

foreach item ${remove_list} {
    remove_attribute  [get_lib_cells  hu55*/${item}]  dont_use
}

# a connecting script for sending and processing SearchContainer signals via SignalManger.gd
# captures user input from the search bar and the filter buttons on the explore page
extends VBoxContainer




# -----
# sends search_string to SignalManager.gd
func _on_SearchBox_text_changed(search_string):
        SignalManager.emit_signal("SearchFilter_signal", "search", search_string)




# sends the RegionFilter option_index to SignalManager.gd
func _on_RegionFilter_item_selected(option_index):
        if option_index < 2:
                SignalManager.emit_signal("RegionFilter_signal", "region", null)
        elif option_index == 2:
                SignalManager.emit_signal("RegionFilter_signal", "region", "nw")
        elif option_index == 3:
                SignalManager.emit_signal("RegionFilter_signal", "region", "ne")
        elif option_index == 4:
                SignalManager.emit_signal("RegionFilter_signal", "region", "ce")
        elif option_index == 5:
                SignalManager.emit_signal("RegionFilter_signal", "region", "sw")
        elif option_index == 6:
                SignalManager.emit_signal("RegionFilter_signal", "region", "se")




# -----
# sends the OutdoorsFilter filter_state to SignalManager.gd
func _on_OutdoorsFilter_toggled(filter_state):
        SignalManager.emit_signal("OutdoorsFilter_signal", "outdoors", filter_state)




# sends the HistoricalFilter filter_state to SignalManager.gd
func _on_HistoricalFilter_toggled(filter_state):
        SignalManager.emit_signal("HistoricalFilter_signal", "historical", filter_state)




# sends the AttractionsFilter filter_state to SignalManager.gd
func _on_AttractionsFilter_toggled(filter_state):
        SignalManager.emit_signal("AttractionsFilter_signal", "attractions", filter_state)




# sends the EntertainmentFilter filter_state to SignalManager.gd
func _on_EntertainmentFilter_toggled(filter_state):
        SignalManager.emit_signal("EntertainmentFilter_signal", "entertainment", filter_state)




# sends the FoodFilter filter_state to SignalManager.gd
func _on_FoodFilter_toggled(filter_state):
        SignalManager.emit_signal("FoodFilter_signal", "food", filter_state)




# -----
# set SearchContainer state to previous stored state on application bootup
func _ready():
        var SearchBox = $"SearchBoxContainer/SearchBox"
        var RegionFilter = $"FilterContainer/ContentContainer/VAlignment/HAlignment/RegionFilter"
        var OutdoorsFilter = $"FilterContainer/ContentContainer/VAlignment/HAlignment/OutdoorsFilter"
        var HistoricalFilter = $"FilterContainer/ContentContainer/VAlignment/HAlignment/HistoricalFilter"
        var AttractionsFilter = $"FilterContainer/ContentContainer/VAlignment/HAlignment/AttractionsFilter"
        var EntertainmentFilter = $"FilterContainer/ContentContainer/VAlignment/HAlignment/EntertainmentFilter"
        var FoodFilter = $"FilterContainer/ContentContainer/VAlignment/HAlignment/FoodFilter"
        
        SearchBox.text = DATA.user["filters"]["search"]
        if DATA.user["filters"]["region"] != null:
                if DATA.user["filters"]["region"] == "nw":
                        RegionFilter.select(2)
                if DATA.user["filters"]["region"] == "ne":
                        RegionFilter.select(3)
                if DATA.user["filters"]["region"] == "ce":
                        RegionFilter.select(4)
                if DATA.user["filters"]["region"] == "sw":
                        RegionFilter.select(5)
                if DATA.user["filters"]["region"] == "se":
                        RegionFilter.select(6)


        if DATA.user["filters"]["outdoors"] == true:
                OutdoorsFilter.set_pressed_no_signal(true)
        if DATA.user["filters"]["historical"] == true:
                HistoricalFilter.set_pressed_no_signal(true)
        if DATA.user["filters"]["attractions"] == true:
                AttractionsFilter.set_pressed_no_signal(true)
        if DATA.user["filters"]["entertainment"] == true:
                EntertainmentFilter.set_pressed_no_signal(true)
        if DATA.user["filters"]["food"] == true:
                FoodFilter.set_pressed_no_signal(true)




# -----
# warning-ignore-all:return_value_discarded
# a connecting script for sending and processing DataBaseCard signals via SignalManger.gd
# captures user input from the cards on the left-hand side of the explore page
extends Panel




# -----
# sends save_request to SignalManager.gd
func _on_SaveFilter_toggled(_save_state):
        var card_id = int(str($".".get_name()).right(4))
        SignalManager.emit_signal("SaveFilter_signal", "saves" , card_id)




# sends view_card_request to SignalManager.gd
func _on_DataBaseCard_gui_input(event):
        if event is InputEventMouseButton and event.get_button_index() == 1 and event.pressed:
                var card_id = int(str($".".get_name()).right(4))
                SignalManager.emit_signal("focus_request", card_id)




# -----
# connects signal on application boot up
func _ready():
        SignalManager.connect("SaveFilter_signal", self, "update_SaveFilter")




# updates the SaveFilter in cases where it was toggled in a different view (i.e on the save page)
func update_SaveFilter(filter, card_id):
        if card_id == int(str($".".get_name()).right(4)):
                if card_id in DATA.user["filters"][filter]:
                        $"MarginContainer/ContentContainer/HeaderContainer/SaveFilter".set_pressed_no_signal(true)
                else:
                        $"MarginContainer/ContentContainer/HeaderContainer/SaveFilter".set_pressed_no_signal(false)




# ------
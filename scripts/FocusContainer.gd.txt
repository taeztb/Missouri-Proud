# warning-ignore-all:unused_variable
# warning-ignore-all:return_value_discarded
# a connecting script for sending and processing FocusContainer signals via SignalManger.gd
# manages right-hand side of the explore page
extends MarginContainer




var focus_path = "Background/MarginContainer/ContentContainer/HAlignment/VAlignment/"




# -----
# Sends save_request to SignalManager.gd
func _on_SaveFilter_toggled(_save_state):
        SignalManager.emit_signal("SaveFilter_signal", "saves", DATA.user["card_id"]["explore_id"])




# adjusts the size of the summary text based on the size of the window
func _on_SummaryText_resized():
                var SummaryText = get_node(focus_path + "SummaryContainer/SummaryText")
                var summary_text_font = SummaryText.get_font("font")
                summary_text_font.size = clamp((((SummaryText.rect_size.x / 18) + (SummaryText.rect_size.y / 14)) / 2), 12, 18)
                SummaryText.add_font_override("font", summary_text_font)




# adjusts the size of the title text based on the size of the window
func _on_TitleText_resized():
                var TitleText = get_node(focus_path + "HeaderContainer/TitleText")
                var title_text_font = TitleText.get_font("font")
                title_text_font.size = clamp((((TitleText.rect_size.x / 8) + (TitleText.rect_size.y / 8)) / 2), 24, 32)
                TitleText.add_font_override("font", title_text_font)




# opens website in default browser when user clicks on a link
func _on_HBoxContainer_gui_input(event):
        if event is InputEventMouseButton and event.get_button_index() == 1 and event.pressed:
                OS.shell_open(DATA.database[DATA.user["card_id"]["explore_id"]]["link"])


# -----
# calls functions on application bootup
func _ready():
        connect_signals()
        update_focus_view(DATA.user["card_id"]["explore_id"])




# Updates the SaveFilter in cases where it was toggled in a different view (i.e card view)
func update_SaveFilter(filter, card_id):
        if card_id == DATA.user["card_id"]["explore_id"]:
                if card_id in DATA.user["filters"][filter]:
                        get_node(focus_path + "HeaderContainer/SaveFilter").set_pressed_no_signal(true)
                else:
                        get_node(focus_path + "HeaderContainer/SaveFilter").set_pressed_no_signal(false)




# formats card into focus view (right_hand side of the screen)
func update_focus_view(card_id):
        # set node paths
        var TitleText = get_node(focus_path + "HeaderContainer/TitleText")
        var SaveFilter = get_node(focus_path + "HeaderContainer/SaveFilter")
        
        var Tag0 = get_node(focus_path + "TagContainer/TagRow1/Tag0")
        var Tag1 = get_node(focus_path + "TagContainer/TagRow2/Tag1")
        var Tag2 = get_node(focus_path + "TagContainer/TagRow2/Tag2")
        var Tag3 = get_node(focus_path + "TagContainer/TagRow2/Tag3")
        var Tag4 = get_node(focus_path + "TagContainer/TagRow3/Tag4")
        var Tag5 = get_node(focus_path + "TagContainer/TagRow3/Tag5")
        
        var SummaryText = get_node(focus_path + "SummaryContainer/SummaryText")
        
        var AmenityInfo = get_node(focus_path + "InfoContainer/InfoRow1/AmenityInfo/MarginContainer/ContentContainer/InfoText")
        var ContactInfo = get_node(focus_path + "InfoContainer/InfoRow1/ContactInfo/MarginContainer/ContentContainer/HBoxContainer2/InfoText")
        var DisabilityInfo = get_node(focus_path + "InfoContainer/InfoRow2/DisabilityInfo/MarginContainer/ContentContainer/InfoText")
        var AgeInfo = get_node(focus_path + "InfoContainer/InfoRow2/AgeInfo/MarginContainer/ContentContainer/InfoText")
        # updates user and makes a save_data_request
        DATA.user["card_id"]["explore_id"] = card_id
        SignalManager.emit_signal("save_data_request")
        
        TitleText.text = DATA.database[card_id]["name"] # Formats TitleText
        if (card_id in DATA.user["filters"]["saves"]) == true: #Determines SaveFilter state
                SaveFilter.set_pressed_no_signal(true)
        else:
                SaveFilter.set_pressed_no_signal(false)
                
        Tag0.text = DATA.database[card_id]["region"] # Formats region tags
        var tags = DATA.database[card_id]["tags"] # Formats other tags
        for index in range(tags.size()):
                if (index + 1) == 1:
                        Tag1.text = tags[index]
                if (index + 1) == 2:
                        Tag2.text = tags[index]
                if (index + 1) == 3:
                        Tag3.text = tags[index]
                if (index + 1) == 4:
                        Tag4.text = tags[index]
                if (index + 1) == 5:
                        Tag5.text = tags[index]
        for index in range(5): # Sets tag visibility
                if (index + 1) == 1:
                        Tag1.visible = true
                        if (index + 1) > tags.size(): 
                                Tag1.visible = false
                if (index + 1) == 2:
                        Tag2.visible = true
                        if (index + 1) > tags.size(): 
                                Tag2.visible = false
                if (index + 1) == 3:
                        Tag3.visible = true
                        if (index + 1) > tags.size(): 
                                Tag3.visible = false
                if (index + 1) == 4:
                        Tag4.visible = true
                        if (index + 1) > tags.size(): 
                                Tag4.visible = false
                if (index + 1) == 5:
                        Tag5.visible = true
                        if (index + 1) > tags.size(): 
                                Tag5.visible = false
        
        SummaryText.text = DATA.database[card_id]["summary_text"] # Format SummaryText
        AmenityInfo.text = DATA.database[card_id]["amenity_info"] # Format AmenityInfo
        ContactInfo.text = DATA.database[card_id]["contact_info"] # Format ContactInfo
        DisabilityInfo.text = DATA.database[card_id]["disability_info"] # Format DisabilityInfo
        AgeInfo.text = DATA.database[card_id]["age_info"] # Format AgeInfo




# connects custom signals via SignalManager.gd
func connect_signals():
        SignalManager.connect("SaveFilter_signal", self, "update_SaveFilter")
        SignalManager.connect("focus_request", self, "update_focus_view")




# ------
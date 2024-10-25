# warning-ignore-all:unused_variable
# warning-ignore-all:return_value_discarded
# manages the save page tab of the Missouri Proud
extends Panel


var save_path = "MarginContainer/Card/CardContainer/Alignment/ContentContainer/VAlignment/"
var BarNotch = load("res://scenes/BarNotch.tscn")
var active = load("res://resources/CurrentBarNotch.tres")
var inactive = load("res://resources/OtherBarNotch.tres")
var local_save = null




# -----
# Sends save_request to SignalManager.gd
func _on_SaveFilter_toggled(_button_pressed):
        SignalManager.emit_signal("SaveFilter_signal", "saves" , DATA.user["card_id"]["save_id"])
        _on_Button1_pressed()




# moves left through the save cards
func _on_Button1_pressed():
        if DATA.user["filters"]["saves"].size() > 0:
                if !(DATA.user["filters"]["saves"].find(DATA.user["card_id"]["save_id"]) - 1 < 0):
                        update_save_view(DATA.user["filters"]["saves"][DATA.user["filters"]["saves"].find(DATA.user["card_id"]["save_id"]) - 1])
                else:
                        update_save_view(DATA.user["filters"]["saves"][DATA.user["filters"]["saves"].size() - 1])
                #update_progress_bar()




# moves right through the save cards
func _on_Button2_pressed():
        if DATA.user["filters"]["saves"].size() > 0:
                if !(DATA.user["filters"]["saves"].find(DATA.user["card_id"]["save_id"]) + 1 == 0):
                        if (DATA.user["filters"]["saves"].find(DATA.user["card_id"]["save_id"]) + 1 <= DATA.user["filters"]["saves"].size() - 1): 
                                update_save_view(DATA.user["filters"]["saves"][DATA.user["filters"]["saves"].find(DATA.user["card_id"]["save_id"]) + 1])
                        else:
                                update_save_view(DATA.user["filters"]["saves"][0])
                else:
                        update_save_view(DATA.user["filters"]["saves"][0])
                #update_progress_bar()




# adjusts the size of the title text based on the size of the window
func _on_TitleText_resized():
                var TitleText = get_node(save_path + "HeaderContainer/TitleText")
                var title_text_font = TitleText.get_font("font")
                title_text_font.size = clamp((((TitleText.rect_size.x / 12) + (TitleText.rect_size.y / 10)) / 2), 32, 48)
                TitleText.add_font_override("font", title_text_font)




# adjusts the size of the summary text based on the size of the window
func _on_SummaryText_resized():
                var SummaryText = get_node(save_path + "SummaryContainer/SummaryText")
                var summary_text_font = SummaryText.get_font("font")
                summary_text_font.size = clamp((((SummaryText.rect_size.x / 24) + (SummaryText.rect_size.y / 14)) / 2), 14, 24)
                SummaryText.add_font_override("font", summary_text_font)




# opens website in default browser when user clicks on a link
func _on_HBoxContainer_gui_input(event):
        if event is InputEventMouseButton and event.get_button_index() == 1 and event.pressed:
                OS.shell_open(DATA.database[DATA.user["card_id"]["save_id"]]["link"])




# -----
# calls functions on application bootup
func _ready():
        connect_signals()
        local_save = DATA.user["filters"]["saves"].duplicate()
        update_save_page("launch", null)




# manages the progress bar at the top of the screen
#as well as the message when no destinations have been saved
func update_save_page(_none, card_id):
        if card_id == DATA.user["card_id"]["save_id"] and _none != "launch":
                _on_Button1_pressed()
        if _none == "launch":
                for save_id in DATA.user["filters"]["saves"]:
                        var bar = BarNotch.instance()
                        bar.set_name("BarNotch" + str(save_id))
                        get_node(save_path + "ProgressBar").add_child(bar)
        if card_id != null:
                if local_save.size() > DATA.user["filters"]["saves"].size() or _none == "launch":
                                get_node(save_path + "ProgressBar").remove_child(get_node(save_path + "ProgressBar/BarNotch" + str(card_id)))
                                local_save = DATA.user["filters"]["saves"].duplicate()
                elif local_save.size() < DATA.user["filters"]["saves"].size(): 
                                var bar = BarNotch.instance()
                                bar.set_name("BarNotch" + str(card_id))
                                get_node(save_path + "ProgressBar").add_child(bar)
                                local_save = DATA.user["filters"]["saves"].duplicate()
        if DATA.user["filters"]["saves"].size() <= 0:
                get_node(save_path).visible = false
                get_node("MarginContainer/Card/CardContainer/Alignment/ContentContainer/NoSavePopUP").visible = true
                get_node("MarginContainer/Card/CardContainer/Alignment/LeftButton/Background/Alignment/Icon").disabled = true
                get_node("MarginContainer/Card/CardContainer/Alignment/RightButton/Background/Alignment/Icon").disabled = true
        elif DATA.user["filters"]["saves"].size() == 1:
                update_save_view(DATA.user["filters"]["saves"][0])
                get_node(save_path).visible = true
                get_node("MarginContainer/Card/CardContainer/Alignment/ContentContainer/NoSavePopUP").visible = false
                get_node("MarginContainer/Card/CardContainer/Alignment/LeftButton/Background/Alignment/Icon").disabled = true
                get_node("MarginContainer/Card/CardContainer/Alignment/RightButton/Background/Alignment/Icon").disabled = true
        else:
                get_node(save_path).visible = true
                update_save_view(DATA.user["card_id"]["save_id"])
                get_node("MarginContainer/Card/CardContainer/Alignment/ContentContainer/NoSavePopUP").visible = false
                get_node("MarginContainer/Card/CardContainer/Alignment/LeftButton/Background/Alignment/Icon").disabled = false
                get_node("MarginContainer/Card/CardContainer/Alignment/RightButton/Background/Alignment/Icon").disabled = false




# formats card into save view 
func update_save_view(card_id):
        # set node paths
        var TitleText = get_node(save_path + "HeaderContainer/TitleText")
        var SaveFilter = get_node(save_path + "HeaderContainer/SaveFilter")
        
        var Tag0 = get_node(save_path + "TagContainer/TagRow1/Tag0")
        var Tag1 = get_node(save_path + "TagContainer/TagRow2/Tag1")
        var Tag2 = get_node(save_path + "TagContainer/TagRow2/Tag2")
        var Tag3 = get_node(save_path + "TagContainer/TagRow2/Tag3")
        var Tag4 = get_node(save_path + "TagContainer/TagRow3/Tag4")
        var Tag5 = get_node(save_path + "TagContainer/TagRow3/Tag5")
        
        var SummaryText = get_node(save_path + "SummaryContainer/SummaryText")
        
        var AmenityInfo = get_node(save_path + "InfoContainer/AmenityInfo/MarginContainer/ContentContainer/InfoText")
        var ContactInfo = get_node(save_path + "InfoContainer/ContactInfo/MarginContainer/ContentContainer/HBoxContainer2/InfoText")
        var DisabilityInfo = get_node(save_path + "InfoContainer/DisabilityInfo/MarginContainer/ContentContainer/InfoText")
        var AgeInfo = get_node(save_path + "InfoContainer/AgeInfo/MarginContainer/ContentContainer/InfoText")
        # updates user and makes a save_data_request
        DATA.user["card_id"]["save_id"] = card_id
        SignalManager.emit_signal("save_data_request")
        
        TitleText.text = DATA.database[card_id]["name"] # Formats TitleText
                
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
        
        for temp_id in DATA.user["filters"]["saves"]:
                if get_node_or_null(save_path + "ProgressBar/BarNotch" + str(temp_id)) != null:
                        get_node(save_path + "ProgressBar/BarNotch" + str(temp_id)).set_theme(inactive)
        if get_node_or_null(save_path + "ProgressBar/BarNotch" + str(card_id)) != null:
                get_node(save_path + "ProgressBar/BarNotch" + str(card_id)).set_theme(active)




# connects custom signals via SignalManager.gd
func connect_signals():
                SignalManager.connect("SaveFilter_signal", self, "update_save_page")




# ------
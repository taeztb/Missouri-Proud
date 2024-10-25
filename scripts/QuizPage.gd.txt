# warning-ignore-all:return_value_discarded
# manages the quiz page tab of the Missouri Proud
extends Panel


var active = load("res://resources/CurrentBarNotch.tres")
var inactive = load("res://resources/OtherBarNotch.tres")




# -----
# starts the quiz
func _on_StartButton_pressed():
        $"MarginContainer/Card/CardContainer/Alignment/ViewContainer".visible = false
        $"MarginContainer/Card/CardContainer/Alignment/ContentContainer/CoverContainer".visible = false
        $"MarginContainer/Card/CardContainer/Alignment/ContentContainer/QuizContainer".visible = true
        if DATA.user["card_id"]["quiz_question_id"] == null:
                DATA.user["card_id"]["quiz_question_id"] = 1
        else:
                get_node("MarginContainer/Card/CardContainer/Alignment/ContentContainer/QuizContainer/ProgressBar/Notch1").set_theme(inactive)
        get_node("MarginContainer/Card/CardContainer/Alignment/ContentContainer/QuizContainer/ProgressBar/Notch" + str(DATA.user["card_id"]["quiz_question_id"])).set_theme(active)
        display_question()




# tracks user-input for answer option A
func _on_Button1_toggled(button_pressed):
        if button_pressed == true:
                DATA.user["quiz_results"]["quiz_answers"][DATA.user["card_id"]["quiz_question_id"]] = "A"
                SignalManager.emit_signal("save_data_request")




# tracks user-input for answer option B
func _on_Button2_toggled(button_pressed):
        if button_pressed == true:
                DATA.user["quiz_results"]["quiz_answers"][DATA.user["card_id"]["quiz_question_id"]] = "B"
                SignalManager.emit_signal("save_data_request")




# tracks user-input for answer option C
func _on_Button3_toggled(button_pressed):
        if button_pressed == true:
                DATA.user["quiz_results"]["quiz_answers"][DATA.user["card_id"]["quiz_question_id"]] = "C"
                SignalManager.emit_signal("save_data_request")




# tracks user-input for answer option D
func _on_Button4_toggled(button_pressed):
        if button_pressed == true:
                DATA.user["quiz_results"]["quiz_answers"][DATA.user["card_id"]["quiz_question_id"]] = "D"
                SignalManager.emit_signal("save_data_request")




# tracks user-input for answer option E
func _on_Button5_toggled(button_pressed):
        if button_pressed == true:
                DATA.user["quiz_results"]["quiz_answers"][DATA.user["card_id"]["quiz_question_id"]] = "E"
                SignalManager.emit_signal("save_data_request")




# tracks user-input for submitting question answers and the quiz
func _on_NextButton_pressed():
        if DATA.user["quiz_results"]["quiz_answers"][DATA.user["card_id"]["quiz_question_id"]] != null and DATA.user["card_id"]["quiz_question_id"] != 10:
                get_node("MarginContainer/Card/CardContainer/Alignment/ContentContainer/QuizContainer/ProgressBar/Notch" + str(DATA.user["card_id"]["quiz_question_id"])).set_theme(inactive)
                DATA.user["card_id"]["quiz_question_id"] += 1
                get_node("MarginContainer/Card/CardContainer/Alignment/ContentContainer/QuizContainer/ProgressBar/Notch" + str(DATA.user["card_id"]["quiz_question_id"])).set_theme(active)
                SignalManager.emit_signal("save_data_request")
                display_question()
        if DATA.user["quiz_results"]["quiz_answers"][DATA.user["card_id"]["quiz_question_id"]] != null and DATA.user["card_id"]["quiz_question_id"] == 10:
                calculate_results()




# executes functions on application bootup
func _ready():
        SignalManager.connect("QuizPage_called", self, "display_results")
        if DATA.user["card_id"]["quiz_question_id"] != null:
                _on_StartButton_pressed()
        if DATA.user["quiz_results"]["quiz_cards"] != null:
                display_results()


# -----
# displays questions and question answers
func display_question():
        var question_bank = {
                1: {
                        "question": "What is the best way to spend a weekend?",
                        "1": "A) Solving a huge jigsaw puzzle",
                        "2": "B) Going on a hike through the wilderness",
                        "3": "C) Meeting up with a good friend",
                        "4": "D) Beating a new game you bought",
                        "5": "E) Binge watching a Netflix show",
                },
                2: {
                        "question": "You are looking for a new show. What genre are you searching for?",
                        "1": "A) A good ol' documentary",
                        "2": "B) A fiesty romance",
                        "3": "C) A popular action-packed show",
                        "4": "D) A suspensful thriller",
                        "5": "E) A niche indie film",
                },
                3: {
                        "question": "You are reading the news. What catches your attention?",
                        "1": "A) A tech start-up's new product",
                        "2": "B) A new animal added to your local zoo",
                        "3": "C) The latest celebrity drama",
                        "4": "D) A dangerous stunt",
                        "5": "E) The trailer for a new movie",
                },
                4: {
                        "question": "It is dinner time. What food are you eating?",
                        "1": "A) A nice homemade meal",
                        "2": "B) An organic dish",
                        "3": "C) Good take-out",
                        "4": "D) Quick frozen food",
                        "5": "E) Something exotic and new",
                },
                5: {
                        "question": "You get a new job, what would it be?",
                        "1": "A) A scientist in a high-tech laboratory",
                        "2": "B) An artisan sculptor in a quaint workshop",
                        "3": "C) A famous actor with a fan club",
                        "4": "D) An aircraft pilot for a major airline",
                        "5": "E) A fashion designer creating new trends",
                },
                6: {
                        "question": "You are at party. What are you doing?",
                        "1": "A) Enjoying the vibes outside the crowd",
                        "2": "B) Left early to relax at home",
                        "3": "C) In the center of crowd",
                        "4": "D) Partying non-stop",
                        "5": "E) Sticking close by friends",
                },
                7: {
                        "question": "You get some downtime. What hobby would you pick up?",
                        "1": "A) Reading that book you have always wanted to read",
                        "2": "B) Cooking and eating from home more",
                        "3": "C) Playing sports for some fun exercise",
                        "4": "D) Skateboarding or biking to get out of the house",
                        "5": "E) Singing and creating musical tunes",
                },
                8: {
                        "question": "On your way to work, what music are you listening to?",
                        "1": "A) A classically composed piece",
                        "2": "B) Fine country tunes",
                        "3": "C) The latest pop hits",
                        "4": "D) Rock'n Roll",
                        "5": "E) Cool blues",
                },
                9: {
                        "question": "You meet a genie. What do you wish for?",
                        "1": "A) The ability to read minds",
                        "2": "B) The power to speak to animals",
                        "3": "C) A hundred million dollars",
                        "4": "D) Superhuman flight",
                        "5": "E) Shape-shifting prowess",
                },
                10: {
                        "question": "Who would you travel with?",
                        "1": "A) Alone",
                        "2": "B) With a spouse",
                        "3": "C) With a big group",
                        "4": "D) With children",
                        "5": "E) With friends",
                },
        }
        var quiz_path = "MarginContainer/Card/CardContainer/Alignment/ContentContainer/QuizContainer/"
        var QuestionText = get_node(quiz_path + "QuestionContainer/VBoxContainer/QuestionText")
        var SubTitleText = get_node(quiz_path + "QuestionContainer/VBoxContainer/SubTitleText")
        var Button1 = get_node(quiz_path + "Button1")
        var Button2 = get_node(quiz_path + "Button2")
        var Button3 = get_node(quiz_path + "Button3")
        var Button4 = get_node(quiz_path + "Button4")
        var Button5 = get_node(quiz_path + "Button5")
        if DATA.user["card_id"]["quiz_question_id"] == 10:
                var NextButton = get_node(quiz_path + "ButtonContainer/HBoxContainer/NextButton")
                NextButton.text = "Finish!"
        QuestionText.text = "Question #" + str(DATA.user["card_id"]["quiz_question_id"])
        SubTitleText.text = question_bank[DATA.user["card_id"]["quiz_question_id"]]["question"]
        Button1.pressed = false
        Button2.pressed = false
        Button3.pressed = false
        Button4.pressed = false
        Button5.pressed = false
        Button1.text = question_bank[DATA.user["card_id"]["quiz_question_id"]]["1"]
        Button2.text = question_bank[DATA.user["card_id"]["quiz_question_id"]]["2"]
        Button3.text = question_bank[DATA.user["card_id"]["quiz_question_id"]]["3"]
        Button4.text = question_bank[DATA.user["card_id"]["quiz_question_id"]]["4"]
        Button5.text = question_bank[DATA.user["card_id"]["quiz_question_id"]]["5"]




# check answers then assigns a result and updates DATA.user
func calculate_results():
        var result_1 = 0
        var result_2 = 0
        var result_3 = 0
        var result_4 = 0
        var result_5 = 0
        
        var results_bank = {
                1: [4,26,47,71,84],
                2: [23,40,63,80,83],
                3: [8,9,28,29,34],
                4: [13,32,53,68,93],
                5: [11,31,69,74,90]
        }
        
        for question in range(1,11):
                var answer = DATA.user["quiz_results"]["quiz_answers"][question]
                if answer == "A":
                        result_1 += 1
                if answer == "B":
                        result_2 += 1
                if answer == "C":
                        result_3 += 1
                if answer == "D":
                        result_4 += 1
                if answer == "E":
                        result_5 += 1
        
        var result_list = []
        result_list.append(result_1)
        result_list.append(result_2)
        result_list.append(result_3)
        result_list.append(result_4)
        result_list.append(result_5)
        
        DATA.user["quiz_results"]["quiz_cards"] = results_bank[result_list.find_last(result_list.max()) + 1]
        SignalManager.emit_signal("save_data_request")
        display_results()




# -----
# moves left through the result cards
func _on_Button1_pressed():
        if !(DATA.user["quiz_results"]["quiz_cards"].find(DATA.user["card_id"]["quiz_result_id"]) - 1 < 0):
                update_result_view(DATA.user["quiz_results"]["quiz_cards"][DATA.user["quiz_results"]["quiz_cards"].find(DATA.user["card_id"]["quiz_result_id"]) - 1])
        else:
                update_result_view(DATA.user["quiz_results"]["quiz_cards"][4])




# moves right through the result cards
func _on_Button2_pressed():
        if DATA.user["quiz_results"]["quiz_cards"].find(DATA.user["card_id"]["quiz_result_id"]) + 1 <= 4:
                update_result_view(DATA.user["quiz_results"]["quiz_cards"][DATA.user["quiz_results"]["quiz_cards"].find(DATA.user["card_id"]["quiz_result_id"]) + 1])
        else:
                update_result_view(DATA.user["quiz_results"]["quiz_cards"][0])




# Sends save_request to SignalManager.gd
func _on_SaveFilter_toggled(_button_pressed):
        SignalManager.emit_signal("SaveFilter_signal", "saves", DATA.user["card_id"]["quiz_result_id"])




# adjusts the size of the title text based on the size of the window
func _on_TitleText_resized():
                var quiz_path = "MarginContainer/Card/CardContainer/Alignment/ViewContainer/ContentContainer/VAlignment/"
                var TitleText = get_node(quiz_path + "HeaderContainer/TitleText")
                var title_text_font = TitleText.get_font("font")
                title_text_font.size = clamp((((TitleText.rect_size.x / 12) + (TitleText.rect_size.y / 10)) / 2), 32, 48)
                TitleText.add_font_override("font", title_text_font)




# adjusts the size of the summary text based on the size of the window
func _on_SummaryText_resized():
                var quiz_path = "MarginContainer/Card/CardContainer/Alignment/ViewContainer/ContentContainer/VAlignment/"
                var SummaryText = get_node(quiz_path + "SummaryContainer/SummaryText")
                var summary_text_font = SummaryText.get_font("font")
                summary_text_font.size = clamp((((SummaryText.rect_size.x / 24) + (SummaryText.rect_size.y / 14)) / 2), 14, 24)
                SummaryText.add_font_override("font", summary_text_font)




# opens website in default browser when user clicks on a link
func _on_HBoxContainer_gui_input(event):
        if event is InputEventMouseButton and event.get_button_index() == 1 and event.pressed:
                OS.shell_open(DATA.database[DATA.user["card_id"]["quiz_result_id"]]["link"])




# -----
# displays retake/view results page and presents the result category
func display_results():
        if DATA.user["quiz_results"]["quiz_cards"] != null:
                $"MarginContainer/Card/CardContainer/Alignment/ViewContainer".visible = false
                $"MarginContainer/Card/CardContainer/Alignment/ContentContainer".visible = true
                $"MarginContainer/Card/CardContainer/Alignment/ContentContainer/CoverContainer".visible = false
                $"MarginContainer/Card/CardContainer/Alignment/ContentContainer/QuizContainer".visible = false
                $"MarginContainer/Card/CardContainer/Alignment/ContentContainer/ResultContainer".visible = true
                
                var quiz_path = "MarginContainer/Card/CardContainer/Alignment/ContentContainer/ResultContainer/"
                var TitleText = get_node(quiz_path + "TitleText")
                if DATA.user["quiz_results"]["quiz_cards"][0] == 4:
                        TitleText.text = "Informed Museums"
                if DATA.user["quiz_results"]["quiz_cards"][0] == 23:
                        TitleText.text = "Scenic Nature"
                if DATA.user["quiz_results"]["quiz_cards"][0] == 8:
                        TitleText.text = "Famous Sites"
                if DATA.user["quiz_results"]["quiz_cards"][0] == 13:
                        TitleText.text = "Amusement Parks"
                if DATA.user["quiz_results"]["quiz_cards"][0] == 11:
                        TitleText.text = "Artistic Theaters"




# resets the quiz page and clear any quiz data in DATA.user
func _on_RetakeButton_pressed():
        var quiz_path = "MarginContainer/Card/CardContainer/Alignment/ContentContainer/QuizContainer/"        
        $"MarginContainer/Card/CardContainer/Alignment/ContentContainer/CoverContainer".visible = true
        $"MarginContainer/Card/CardContainer/Alignment/ContentContainer/QuizContainer".visible = false
        $"MarginContainer/Card/CardContainer/Alignment/ContentContainer/ResultContainer".visible = false
        $"MarginContainer/Card/CardContainer/Alignment/ViewContainer".visible = false
        $"MarginContainer/Card/CardContainer/Alignment/ContentContainer/QuizContainer/ProgressBar/Notch1".set_theme(active)
        $"MarginContainer/Card/CardContainer/Alignment/ContentContainer/QuizContainer/ProgressBar/Notch10".set_theme(inactive)
        for index in range(1,11):
                DATA.user["quiz_results"]["quiz_answers"][index] = null
        DATA.user["quiz_results"]["quiz_cards"] = null
        DATA.user["card_id"]["quiz_question_id"] = null
        DATA.user["card_id"]["quiz_result_id"] = null
        var NextButton = get_node(quiz_path + "ButtonContainer/HBoxContainer/NextButton")
        NextButton.text = "Next Question"
        SignalManager.emit_signal("save_data_request")




# displays result cards
func _on_ViewResultButton_pressed():
        $"MarginContainer/Card/CardContainer/Alignment/ContentContainer".visible = false
        $"MarginContainer/Card/CardContainer/Alignment/ViewContainer".visible = true
        update_result_view(DATA.user["quiz_results"]["quiz_cards"][0])




# formats card into result view 
func update_result_view(card_id):
        # set node paths
        var quiz_path = "MarginContainer/Card/CardContainer/Alignment/ViewContainer/ContentContainer/VAlignment/"
        var TitleText = get_node(quiz_path + "HeaderContainer/TitleText")
        var SaveFilter = get_node(quiz_path + "HeaderContainer/SaveFilter")
        
        var Tag0 = get_node(quiz_path + "TagContainer/TagRow1/Tag0")
        var Tag1 = get_node(quiz_path + "TagContainer/TagRow2/Tag1")
        var Tag2 = get_node(quiz_path + "TagContainer/TagRow2/Tag2")
        var Tag3 = get_node(quiz_path + "TagContainer/TagRow2/Tag3")
        var Tag4 = get_node(quiz_path + "TagContainer/TagRow3/Tag4")
        var Tag5 = get_node(quiz_path + "TagContainer/TagRow3/Tag5")
        
        var SummaryText = get_node(quiz_path + "SummaryContainer/SummaryText")
        
        var AmenityInfo = get_node(quiz_path + "InfoContainer/AmenityInfo/MarginContainer/ContentContainer/InfoText")
        var ContactInfo = get_node(quiz_path + "InfoContainer/ContactInfo/MarginContainer/ContentContainer/HBoxContainer2/InfoText")
        var DisabilityInfo = get_node(quiz_path + "InfoContainer/DisabilityInfo/MarginContainer/ContentContainer/InfoText")
        var AgeInfo = get_node(quiz_path + "InfoContainer/AgeInfo/MarginContainer/ContentContainer/InfoText")
        # updates user and makes a save_data_request
        DATA.user["card_id"]["quiz_result_id"] = card_id
        SignalManager.emit_signal("save_data_request")
        
        TitleText.text = DATA.database[card_id]["name"] # Formats TitleText
        if card_id in DATA.user["filters"]["saves"]:
                SaveFilter.pressed = true
        else:
                SaveFilter.pressed = false
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
        
        for index in range(1, DATA.user["quiz_results"]["quiz_cards"].size() + 1):
                get_node(quiz_path + "ProgressBar/Notch" + str(index)).set_theme(inactive)
        get_node(quiz_path + "ProgressBar/Notch" + str(DATA.user["quiz_results"]["quiz_cards"].find(card_id) + 1)).set_theme(active)




# -----
# warning-ignore-all:return_value_discarded
# manages DataBaseCards, queueing display and hide.
extends MarginContainer




# load node_path/file_path
var explore_path = "ContentContainer/VAlignment/HAlignment"
onready var parent_location = get_node(explore_path)
var rng = RandomNumberGenerator.new()
var database_card = load("res://scenes/DataBaseCard.tscn")


# assign variables to keep track of displaying database_cards
var on_screen = []
var display_queue = []
var hide_queue = []


# -----
# calls functions on application bootup
func _ready():
        connect_signals()
        update_queue()




# -----
# checks DATA.user["filters"] and updates the queue
func update_queue():
        var temp_queue = []
        # checks if any filters are pressed
        if DATA.user["filters"].values().has(true):
                # checks OutdoorsFilter
                if DATA.user["filters"]["outdoors"] == true: 
                        if temp_queue.empty() == true:
                                temp_queue += DATA.database["outdoors_list"]
                        else:
                                for card_id in temp_queue.duplicate():
                                        if !(card_id in DATA.database["outdoors_list"]):
                                                temp_queue.erase(card_id)
                                if temp_queue.size() == 0:
                                        temp_queue.append(null)
                 # checks HistoricalFilter
                if DATA.user["filters"]["historical"] == true:
                        if temp_queue.empty() == true:
                                temp_queue += DATA.database["historical_list"]
                        else:
                                for card_id in temp_queue.duplicate():
                                        if !(card_id in DATA.database["historical_list"]):
                                                temp_queue.erase(card_id)
                                if temp_queue.size() == 0:
                                        temp_queue.append(null)
                 # checks AttractionsFilter
                if DATA.user["filters"]["attractions"] == true:
                        if temp_queue.empty() == true:
                                temp_queue += DATA.database["attractions_list"]
                        else:
                                for card_id in temp_queue.duplicate():
                                        if !(card_id in DATA.database["attractions_list"]):
                                                temp_queue.erase(card_id)
                                if temp_queue.size() == 0:
                                        temp_queue.append(null)
                # checks EntertainmentFilter
                if DATA.user["filters"]["entertainment"] == true: 
                        if temp_queue.empty() == true:
                                temp_queue += DATA.database["entertainment_list"]
                        else:
                                for card_id in temp_queue.duplicate():
                                        if !(card_id in DATA.database["entertainment_list"]):
                                                temp_queue.erase(card_id)
                                if temp_queue.size() == 0:
                                        temp_queue.append(null)
                 # checks FoodFilter
                if DATA.user["filters"]["food"] == true: 
                        if temp_queue.empty() == true:
                                temp_queue += DATA.database["food_list"]
                        else:
                                for card_id in temp_queue.duplicate():
                                        if !(card_id in DATA.database["food_list"]):
                                                temp_queue.erase(card_id)
                                if temp_queue.size() == 0:
                                        temp_queue.append(null)
         # no filters
        else:
                temp_queue += DATA.database["id_list"]
        # no results
        if null in temp_queue: 
                temp_queue.clear()
        # remove duplicates in the temp_queue
        for card_id in temp_queue: 
                while temp_queue.count(card_id) > 1:
                        temp_queue.erase(card_id)
         # check Region Filter
        if DATA.user["filters"]['region'] != null:
                var region_list = DATA.database[DATA.user["filters"]['region'] + "_list"]
                for card_id in temp_queue.duplicate():
                        if !(card_id in region_list):
                                temp_queue.erase(card_id)
        # check Cards on screen
        for card_id in on_screen:
                if !(card_id in temp_queue):
                        hide_queue.append(card_id)
                # check Search Bar
                if DATA.user["filters"]["search"] != null:
                        if !(DATA.user["filters"]["search"].is_subsequence_ofi(DATA.database[card_id]["name"])):
                                hide_queue.append(card_id)
        for card_id in temp_queue.duplicate():
                # check Search Bar
                if DATA.user["filters"]["search"] != null:
                        if !(DATA.user["filters"]["search"].is_subsequence_ofi(DATA.database[card_id]["name"])):
                                temp_queue.erase(card_id)
                # remove any remaining duplicates
                if card_id in on_screen:
                        temp_queue.erase(card_id)
                elif card_id in display_queue:
                        temp_queue.erase(card_id)
        for card_id in temp_queue:
                        display_queue.append(card_id)
        iterate_queue()




# calls the display and hide functions while processing queue
func iterate_queue():
        while hide_queue.size() > 0:
                hide_card(hide_queue[0])
        while display_queue.size() > 0:
                display_card(display_queue[0])




# displays a card on_screen
func display_card(card_id):
        # create a new DataBase_Card assign an id and add it to the scene tree
        var card = database_card.instance()
        card.set_name("Card" + str(card_id))
        get_node(explore_path).add_child(card)
        
        # set node paths for later use
        var card_path = get_node(explore_path + "/Card" + str(card_id))
        var TitleText =get_node(explore_path + "/Card" + str(card_id) + "/MarginContainer/ContentContainer/HeaderContainer/TitleText")
        var SaveFilter = get_node(explore_path + "/Card" + str(card_id) + "/MarginContainer/ContentContainer/HeaderContainer/SaveFilter")
        var Tag0 = get_node(explore_path + "/Card" + str(card_id) + "/MarginContainer/ContentContainer/TagContainer/Tag0")
        var Tag1 = get_node(explore_path + "/Card" + str(card_id) + "/MarginContainer/ContentContainer/TagContainer/Tag1")
        var Tag2 = get_node(explore_path + "/Card" + str(card_id) + "/MarginContainer/ContentContainer/TagContainer/Tag2")
        var Tag3 = get_node(explore_path + "/Card" + str(card_id) + "/MarginContainer/ContentContainer/TagContainer/Tag3")
        var SummaryText = get_node(explore_path + "/Card" + str(card_id) + "/MarginContainer/ContentContainer/SummaryText")
        
        
        # configure card with information from DataBase
        rng.randomize()
        var node_placement = 0
        if on_screen.size() - 1 == -1:
                pass
        else:
                node_placement = rng.randi_range(0, on_screen.size() - 1)
        get_node(explore_path).move_child(card_path, node_placement)
        
        TitleText.text = DATA.database[card_id]["name"]
        if DATA.user["filters"]["saves"].has(card_id) == true:
                SaveFilter.set_pressed_no_signal(true)
        else:
                SaveFilter.set_pressed_no_signal(false)
        Tag0.text = DATA.database[card_id]["region"]
        var tags = DATA.database[card_id]["tags"]
        Tag1.text = tags[0]
        if DATA.database[card_id]["tags"].size() > 1:
                Tag2.text = tags[1]
                Tag3.visible = true
        else:
                Tag2.visible = false
        if DATA.database[card_id]["tags"].size() > 2:
                Tag3.visible = true
        else:
                Tag3.visible = false
        SummaryText.text = DATA.database[card_id]["summary_text"]
        
        on_screen.append(display_queue.pop_front())




# hides a card on_screen
func hide_card(card_id):
        var card_path = get_node("ContentContainer/VAlignment/HAlignment/Card" + str(card_id))
        get_node(explore_path).remove_child(card_path)
        on_screen.erase(hide_queue.pop_front())




# connects custom signals via SignalManager.gd
func connect_signals():
        SignalManager.connect("queue_request", self, "update_queue")




# -----
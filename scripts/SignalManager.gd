# Global singleton script for managing and storing custom signals
# warning-ignore-all:unused_signal
extends Node




# -----
# Nested node request signals
signal save_data_request() # emitted by FocusContainer.gd
signal queue_request() # emitted by DATA.gd
signal focus_request(index) # emitted by DataBaseCard.gd
signal QuizPage_called(index)


# Database search signals
signal SearchFilter_signal(filter, search_string) # emitted by SearchContainer.gd
signal RegionFilter_signal(filter, region) # emitted by SearchContainer.gd
signal SaveFilter_signal(filter, card_id) # emitted by DataBaseCard.gd and FocusContainer.gd


signal OutdoorsFilter_signal(filter, filter_state) # emitted by SearchContainer.gd
signal HistoricalFilter_signal(filter, filter_state) # emitted by SearchContainer.gd
signal AttractionsFilter_signal(filter, filter_state) # emitted by SearchContainer.gd
signal EntertainmentFilter_signal(filter, filter_state) # emitted by SearchContainer.gd
signal FoodFilter_signal(filter, filter_state) # emitted by SearchContainer.gd




# -----
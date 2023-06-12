extends "res://ui/screens/ScreenBase.gd"

signal go_to_card_list_stats
signal go_to_card_stats

onready var _change_deck = $MarginContainer/Layout/ChangeDeck as Control

onready var _total_reviews = $MarginContainer/Layout/Content/FirstColumn/TotalReviews as Control
onready var _RD_average = $MarginContainer/Layout/Content/FirstColumn/RDAverage as Control
onready var _total_days = $MarginContainer/Layout/Content/TotalDays as Control
onready var _day_in_row = $MarginContainer/Layout/Content/SecondColumn/DaysInRow as Control
onready var _DIR_record = $MarginContainer/Layout/Content/SecondColumn/DIRRecord as Control

func _ready() -> void:
	_change_deck.connect("normal_flip", self, "_on_change_deck_pressed")

func start () -> void:
	_update_current_deck()
	_error_suporter()
	
	_update_values()

func _update_values() -> void: 
	var _total_reviews_count : float = 0.0
	var _RD_average_calculated : float = 0.0
	var _total_days_count : float = 0.0
	var _days_in_row_count : float = 0.0
	var _DIR_record_amount : float = 0.0
	
	if USERDATA.current_deck_data:
		for _c in USERDATA.current_deck_data["cards"]:
			_total_reviews_count += _c["hits"] + _c["fails"]
		
		var _dh_q : String = "SELECT date FROM Deck_History WHERE deck_id = " + str(USERDATA.current_deck_data["deck_id"])
		_total_days_count = USERDATA.get_by_query(_dh_q).size()
		
		if _total_days_count > 0:
			_RD_average_calculated = _total_reviews_count / _total_days_count
		
		_days_in_row_count = USERDATA.current_deck_data["days_on_streak"]
		_DIR_record_amount = USERDATA.current_deck_data["days_on_streak_record"]
	
	_total_reviews.set_values(_total_reviews_count)
	_total_days.set_values(_total_days_count)
	_RD_average.set_values(_RD_average_calculated)
	_day_in_row.set_values(_days_in_row_count)
	_DIR_record.set_values(_DIR_record_amount)

func _update_current_deck() -> void:
	if USERDATA.current_deck_data:
		_change_deck.set_title(USERDATA.current_deck_data["title"])

func _on_change_deck_pressed(_button : Control) -> void:
	emit_signal("change_deck_requested", _button)

func _on_LeftButton_button_down() -> void:
	emit_signal("go_to_card_stats", null)

func _on_RightButton_button_down() -> void:
	emit_signal("go_to_card_list_stats", null)

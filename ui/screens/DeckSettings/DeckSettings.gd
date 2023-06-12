extends "res://ui/screens/ScreenBase.gd"

signal go_to_user_settings_requested

signal edit_deck_settings(deck_settings)
signal edit_deck(deck)
signal delete_deck

onready var _change_deck = $MarginContainer/Layout/ChangeDeck as Control
onready var _scroll_container = $MarginContainer/Layout/ScrollContainer as ScrollContainer
onready var _new_cards_per_day = $MarginContainer/Layout/ScrollContainer/Content/NewCardsPerDay as MarginContainer
onready var _pending_state = $MarginContainer/Layout/ScrollContainer/Content/PendingState as MarginContainer
onready var _new_name_input = $MarginContainer/Layout/ScrollContainer/Content/NewNameInput as MarginContainer
onready var _delete_button = $MarginContainer/Layout/ScrollContainer/Content/DeleteButton/DeleteButton as Control

func _ready() -> void:
	_change_deck.connect("normal_flip", self, "_on_change_deck_pressed")
	
	start()

func start() -> void:
	_update_current_deck()
	_error_suporter()
	_restart_values()
	
	if USERDATA.current_deck_data:
		var _new_cards_value : int = USERDATA.current_deck_data["settings"]["new_cards_per_day"]
		var _pending_value : bool = false
		match USERDATA.current_deck_data["settings"]["state"]:
			"ACTIVE":
				_pending_value = true
			_:
				_pending_value = false
		_set_values(_new_cards_value, _pending_value)

func _restart_values () -> void:
	_new_name_input.restart()
	_delete_button.restart()
	_scroll_container.scroll_vertical = 0

func _update_current_deck() -> void:
	if USERDATA.current_deck_data:
		_change_deck.set_title(USERDATA.current_deck_data["title"])

func _set_values(var _new_cards_value : int, var _pending_value : bool) -> void:
	_new_cards_per_day.new_number = _new_cards_value
	_pending_state.new_status = _pending_value

func _on_change_deck_pressed(_button : Control) -> void:
	emit_signal("change_deck_requested", _button)

func _on_Footer_edit_deck() -> void:
	var _new_name_value : String = _new_name_input.value
	var _new_deck_settings : Dictionary = USERDATA.current_deck_data.duplicate()["settings"]
	_new_deck_settings["new_cards_per_day"] = _new_cards_per_day.value
	_new_deck_settings["state"] = _pending_state.value
	
	emit_signal("edit_deck_settings", _new_deck_settings)
	
	var _deck_can_update : bool = true
	
	for _d in USERDATA.decks_data:
		if TEXTFORMAT.remove_unnecessary_space(_new_name_value).to_upper() == _d["title"].to_upper():
			_deck_can_update = false
			break
	
	if _deck_can_update:
		var _deck_info : Dictionary = {
			"deck_id": USERDATA.current_deck_data["deck_id"],
			"user_id": USERDATA.current_deck_data["user_id"],
			"title": TEXTFORMAT.remove_unnecessary_space(_new_name_value),
			"days_on_streak": USERDATA.current_deck_data["days_on_streak"],
			"days_on_streak_record": USERDATA.current_deck_data["days_on_streak_record"],
		}
		if TEXTFORMAT.remove_unnecessary_space(_new_name_value) != "":
			emit_signal("edit_deck", _deck_info)
		_new_name_input.set_color("PRIMARY")
	else:
		_new_name_input.set_color("DANGER")
	
	start()

# warning-ignore:unused_argument
func _on_DangerousButton_front_flip(button):
	emit_signal("delete_deck", false)

func _on_Footer_go_to_user_settings():
	emit_signal("go_to_user_settings_requested", null)

extends Control

const CARD = preload("res://ui/screens/Decks/components/Card/Card.tscn")

signal go_to_new_card_screen_requested(card_id)
signal go_to_practice_screen_requested
signal go_to_statistics_screen_requested
signal go_to_settings_screen_requested
signal change_deck_requested

onready var _change_deck = $MarginContainer/Layout/ChangeDeck as Control
onready var _card_preview = $MarginContainer/Layout/ScrollContainer/Content/CardPreview as Control
onready var _card_column = $MarginContainer/Layout/ScrollContainer/Content/CardColumn as VBoxContainer
onready var _search_bar = $FloatingColumn/SearchBar

onready var _add_buttons_bar = $FloatingColumn/ButtonsBar/MarginContainer/Layout/Add as Control
onready var _practice_buttons_bar = $FloatingColumn/ButtonsBar/MarginContainer/Layout/Practice as Control
onready var _stats_buttons_bar = $FloatingColumn/ButtonsBar/MarginContainer/Layout/Stats as Control
onready var _settings_buttons_bar = $FloatingColumn/ButtonsBar/MarginContainer/Layout/Settings as Control

var _card_array : Array = []

func _ready() -> void:
	_change_deck.connect("normal_flip", self, "_on_change_deck_pressed")
	_search_bar.connect("search", self, "_on_search")
	
	_add_buttons_bar.connect("normal_flip", self, "_on_add_button_pressed")
	_practice_buttons_bar.connect("normal_flip", self, "_on_practice_button_pressed")
	_stats_buttons_bar.connect("normal_flip", self, "_on_stats_button_pressed")
	_settings_buttons_bar.connect("normal_flip", self, "_on_settings_button_pressed")

	start()

func start() -> void:
	_card_array = _load_data()
	_card_preview.start()
	_update_current_deck()
	_remove_all_cards()
	_insert_card_array("")

func _update_current_deck() -> void:
	if USERDATA.current_deck_data:
		_change_deck.set_title(USERDATA.current_deck_data["title"])

func _load_data() -> Array:
	var _result_array : Array
	
	if USERDATA.current_deck_data:
		for _c in USERDATA.current_deck_data["cards"]:
			_result_array.append(_create_card(_c["card_id"], _c["question"]["title"], _c["answer"]["title"], _c["answer"]["description"]))
	
	return _result_array

func _create_card(var _id : int, var _question : String, var _answer : String, var _answer_description : String) -> Control:
	var _card : Control = CARD.instance()
	
	_card.id = _id
	_card.question_title = _question
	_card.answer_title = _answer
	_card.answer_description = _answer_description
	
# warning-ignore:return_value_discarded
	_card.connect("back_flip", self, "_on_switch_card_to_front")
# warning-ignore:return_value_discarded
	_card.connect("card_pressed", self, "_on_card_pressed")
	
	return _card

func _insert_card_array(_search : String) -> void:
	for _c in _card_array:
		if _search.to_upper() in _c.question_title.to_upper() or _search.to_upper() in _c.answer_title.to_upper() or _search == "":
			_card_column.add_child(_c)

func _remove_all_cards() -> void:
	for _c in _card_column.get_children():
		_card_column.remove_child(_c)

func _on_change_deck_pressed(_button : Control) -> void:
	emit_signal("change_deck_requested", _button)

func _on_search(text : String) -> void:
	_remove_all_cards()
	_insert_card_array(text)

func _on_switch_card_to_front(_card: Control) -> void:
	for _c in _card_array:
		if _c == _card:
			pass
		else:
			if _c.side == "BACK":
				_c.back_action()

func _on_card_pressed(_button : Control) -> void:
	emit_signal("go_to_new_card_screen_requested", _button)

func _on_add_button_pressed(_button : Control) -> void:
	emit_signal("go_to_new_card_screen_requested", null)

func _on_practice_button_pressed(_button : Control) -> void:
	emit_signal("go_to_practice_screen_requested", null)

func _on_stats_button_pressed(_button : Control) -> void:
	emit_signal("go_to_statistics_screen_requested")

func _on_settings_button_pressed(_button : Control) -> void:
	emit_signal("go_to_settings_screen_requested")

extends "res://ui/screens/ScreenBase.gd"

signal go_to_card_list_stats
signal go_to_deck_stats

onready var _change_deck = $MarginContainer/Layout/ChangeDeck as Control

onready var _total_cards = $MarginContainer/Layout/FirstRowStats/TotalCards as Control
onready var _completed_cards = $MarginContainer/Layout/FirstRowStats/CompletedCards as Control
onready var _in_proccess_cards = $MarginContainer/Layout/FirstRowStats/InProccessCards as Control
onready var _new_cards = $MarginContainer/Layout/FirstRowStats/NewCards as Control

onready var _graph = $MarginContainer/Layout/Graph as MarginContainer
onready var _current_theme = USERDATA.current_theme as String

func _ready() -> void:
	_change_deck.connect("normal_flip", self, "_on_change_deck_pressed")

func start () -> void:
	_update_current_deck()
	_error_suporter()
	
	_update_values()

func _update_values() -> void: 
	var _total_count : float = 0
	var _completed_count : float = 0
	var _in_proccess_count : float = 0
	var _new_count : float = 0
	
	if USERDATA.current_deck_data:
		_total_count = USERDATA.current_deck_data["cards"].size()
		for _c in USERDATA.current_deck_data["cards"]:
			var _hits_percent : float = 0
			
			var _total_sessions : float = _c["fails"] + _c["hits"]
			if _total_sessions > 0:
				_hits_percent = _c["hits"] * 100 / _total_sessions
			
			if _total_sessions >= 10 and _hits_percent >= 60:
				_completed_count += 1
			elif _total_sessions > 0:
				_in_proccess_count += 1
			else:
				_new_count += 1
	
	_total_cards.set_values(_total_count)
	_completed_cards.set_values(_completed_count)
	_in_proccess_cards.set_values(_in_proccess_count)
	_new_cards.set_values(_new_count)
	
	var _completed_percent : float = 0.0
	var _in_proccess_percent : float = 0.0
	var _new_cards_percent : float = 0.0
	if _total_count > 0: 
		_completed_percent = _completed_count * 100 /  _total_count
		_in_proccess_percent = _in_proccess_count * 100 / _total_count
		_new_cards_percent = _new_count * 100 / _total_count
	
	var _item_value : Array =[
		{"color": THEMES.DICT_THEMES[_current_theme]["GRAPH_ITEM_1"], "percent": 360 * _completed_percent / 100}, #360 is the circle angle
		{"color": THEMES.DICT_THEMES[_current_theme]["GRAPH_ITEM_2"], "percent": 360 * _in_proccess_percent / 100},
		{"color": THEMES.DICT_THEMES[_current_theme]["GRAPH_ITEM_3"], "percent": 360 * _new_cards_percent / 100}
	]
	
	_graph.set_pie_chart(_item_value)

func _update_current_deck() -> void:
	if USERDATA.current_deck_data:
		_change_deck.set_title(USERDATA.current_deck_data["title"])

func _on_change_deck_pressed(_button : Control) -> void:
	emit_signal("change_deck_requested", _button)

func _on_LeftButton_button_down() -> void:
	emit_signal("go_to_card_list_stats", null)

func _on_RightButton_button_down() -> void:
	emit_signal("go_to_deck_stats", null)

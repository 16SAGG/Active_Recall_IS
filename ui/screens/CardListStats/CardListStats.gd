extends "res://ui/screens/ScreenBase.gd"

signal go_to_card_stats
signal go_to_deck_stats

const CARD_INFO = preload("res://ui/screens/CardListStats/components/CardInfo/CardInfo.tscn")

onready var _scroll_container = $MarginContainer/Layout/CardList/Content/ScrollContainer as ScrollContainer
onready var _change_deck = $MarginContainer/Layout/ChangeDeck as Control
onready var _cards = $MarginContainer/Layout/CardList/Content/ScrollContainer/Cards as VBoxContainer
onready var _header = $MarginContainer/Layout/CardList/Content/Header as Control

var _card_array : Array = []

func _ready() -> void:
	_change_deck.connect("normal_flip", self, "_on_change_deck_pressed")

func start() -> void:
	_update_current_deck()
	_error_suporter()
	
	if USERDATA.current_deck_data:
		_card_array = _load_data()
		_remove_all_cards()
		for i in range(0, 2):
			_header.concept_button.front_action()
	
	_scroll_container.scroll_vertical = 0

func _update_current_deck() -> void:
	if USERDATA.current_deck_data:
		_change_deck.set_title(USERDATA.current_deck_data["title"])

func _load_data() -> Array:
	var _result_array : Array
	for _c in USERDATA.current_deck_data["cards"]:
		var _question : String = _c["question"]["title"]
		var _answer : String = _c["answer"]["title"]
		var _reviews: float = _c["hits"] + _c["fails"]
		var _hits : float = _c["hits"]
		var _effectivity : float = 0.0
		if _reviews > 0:
			_effectivity = _hits * 100 / _reviews
		
		_result_array.append(_create_card_info(_question, _answer, _reviews, _hits, _effectivity))
	
	return _result_array

func _create_card_info(var _question : String, var _answer : String, var _reviews : float, var _hits : float, var _effectivity : float) -> Control:
	var _card_info : Control = CARD_INFO.instance()
	
	_card_info.question = _question
	_card_info.answer = _answer
	_card_info.reviews = _reviews
	_card_info.hits = _hits
	_card_info.effectivity = _effectivity
	
	return _card_info

class MyCustomSorter:
	static func sort_concept_ascending(a, b):
		if a.question.to_lower() < b.question.to_lower():
			return true
		return false
	static func sort_review_ascending(a, b):
		if a.reviews < b.reviews:
			return true
		return false
	static func sort_hit_ascending(a, b):
		if a.hits < b.hits:
			return true
		return false
	static func sort_effectivity_ascending(a, b):
		if a.effectivity < b.effectivity:
			return true
		return false
	static func sort_concept_descending(a, b):
		if a.question.to_lower() > b.question.to_lower():
			return true
		return false
	static func sort_review_descending(a, b):
		if a.reviews > b.reviews:
			return true
		return false
	static func sort_hit_descending(a, b):
		if a.hits > b.hits:
			return true
		return false
	static func sort_effectivity_descending(a, b):
		if a.effectivity > b.effectivity:
			return true
		return false


func _insert_card_array(var _order : String, var _orientation : String) -> void:
	_card_array.sort_custom(MyCustomSorter, "sort_"+ _order.to_lower() + "_" + _orientation)
	
	for _c in _card_array:
		_cards.add_child(_c)

func _remove_all_cards() -> void:
	for _c in _cards.get_children():
		_cards.remove_child(_c)

func _on_change_deck_pressed(_button : Control) -> void:
	emit_signal("change_deck_requested", _button)

func _on_LeftButton_button_down() -> void:
	emit_signal("go_to_deck_stats", null)

func _on_RightButton_button_down() -> void:
	emit_signal("go_to_card_stats", null)

func _on_Header_concept_order(var _orientation : String)-> void:
	_remove_all_cards()
	_insert_card_array("CONCEPT", _orientation)

func _on_Header_review_order(var _orientation : String) -> void :
	_remove_all_cards()
	_insert_card_array("REVIEW", _orientation)

func _on_Header_hit_order(var _orientation : String) -> void :
	_remove_all_cards()
	_insert_card_array("HIT", _orientation)

func _on_Header_effectivity_order(var _orientation : String)-> void:
	_remove_all_cards()
	_insert_card_array("EFFECTIVITY", _orientation)


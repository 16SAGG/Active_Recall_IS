extends Control

signal hide_change_deck_pop_up_requested
signal change_current_deck(id)

const CHANGE_DECK_ELEMENT = preload("res://ui/components/ChangeDeckPopUp/components/ChangeDeckElement.tscn")

export var showed : bool = false setget _setget_showed

onready var animation_player = $AnimationPlayer
onready var _content_column = $Pivot/MarginContainer/Layout/ScrollContainer/Content
onready var _search_line = $Pivot/MarginContainer/Layout/SearchLine as LineEdit
onready var _mouse_detector = $MouseDetector as Control

var _deck_array : Array = []

func _ready() -> void:
	_mouse_detector.connect("click_outside", self, "_on_click_outside")
	start()

func start() -> void:
	_deck_array = _load_data()
	_remove_all_decks()
	_insert_deck_array("")
	if USERDATA.current_deck_data:
		_search_line.text = USERDATA.current_deck_data["title"]

func _setget_showed(var _showed : bool) -> void:
	showed = _showed
	if _mouse_detector:
		_mouse_detector.active = _showed

func _load_data() -> Array:
	var _result_array : Array
	for _d in USERDATA.decks_data:
		_result_array.append(_create_change_deck_element(_d.title, _d.deck_id))
	
	return _result_array

func _create_change_deck_element(_title : String, _id : int) -> Control:
	var _change_deck_element : Control = CHANGE_DECK_ELEMENT.instance()
	
	_change_deck_element.id = _id
	_change_deck_element.title = _title
	
	 #warning-ignore:return_value_discarded
	_change_deck_element.connect("back_flip", self, "_on_switch_deck_to_front")
	# warning-ignore:return_value_discarded
	_change_deck_element.connect("pressed", self, "_on_deck_pressed")
	
	return _change_deck_element

func _insert_deck_array(_search : String) -> void:
	for _d in _deck_array:
		if _search.to_upper() in _d.title.to_upper() or _search == "":
			_content_column.add_child(_d)

func _remove_all_decks() -> void:
	for _c in _content_column.get_children():
		_content_column.remove_child(_c)

func _on_switch_deck_to_front(_deck: Control) -> void:
	for _db in _deck_array:
		if _db == _deck:
			pass
		else:
			if _db.side == "BACK":
				_db.back_action()

func _on_deck_pressed(_deck : Control) -> void:
	emit_signal("change_current_deck", _deck.id)
	_on_switch_deck_to_front(null)

func _on_click_outside():
	emit_signal("hide_change_deck_pop_up_requested")

func _on_SearchLine_text_changed(new_text):
	_remove_all_decks()
	_insert_deck_array(new_text)

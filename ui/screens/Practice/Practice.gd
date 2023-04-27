extends Control

const OPTION_BOX = preload("res://ui/screens/Practice/components/OptionBox/OptionBox.tscn")

signal change_deck_requested
signal practice_flash_card_screen_requested
signal practice_test_screen_requested
signal practice_memory_screen_requested

onready var _change_deck = $MarginContainer/Layout/ChangeDeck
onready var _option_preview = $MarginContainer/Layout/OptionPreview as Control
onready var _options_container = $MarginContainer/Layout/OptionScroll/Content as HBoxContainer

var _option_values : Array = [
	{
		"title": "Flash Card",
		"dir": "flash_card"
	},
	{
		"title": "Test",
		"dir": "test"
	},
	{
		"title": "Memory",
		"dir": "memory"
	},
]

var _option_array : Array

func _ready():
	_change_deck.connect("normal_flip", self, "_on_change_deck_pressed")
	
	_option_preview.set_option_array(_option_values)
	_option_array = _load_data()
	_insert_option_array()
	
	start()

func start() -> void:
	_update_current_deck()

func _load_data() -> Array:
	var _result_array : Array
	for _o in _option_values:
		_result_array.append(_create_option_box(_o["title"], _o["dir"]))
	return _result_array

func _create_option_box(var _title: String, var _dir: String) -> Control:
	var _option_box : Control = OPTION_BOX.instance()
	
	_option_box.title = _title
	_option_box.dir = _dir
	
# warning-ignore:return_value_discarded
	_option_box.connect("back_flip", self, "_on_switch_box_to_front")
# warning-ignore:return_value_discarded
	_option_box.connect("option_pressed", self, "_on_option_pressed")
	
	return _option_box

func _insert_option_array() -> void:
	for _o in _option_array:
		_options_container.add_child(_o)

func _update_current_deck() -> void:
	if USERDATA.current_deck_data:
		_change_deck.set_title(USERDATA.current_deck_data["title"])

func _on_change_deck_pressed(_button : Control) -> void:
	emit_signal("change_deck_requested", _button)

func _on_switch_box_to_front(_option: Control) -> void:
	for _o in _option_array:
		if _o == _option:
			pass
		else:
			if _o.side == "BACK":
				_o.back_action()

func _on_option_pressed(_dir: String) -> void:
	emit_signal("practice_" + _dir + "_screen_requested")

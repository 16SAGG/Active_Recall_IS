extends "res://ui/screens/ScreenBase.gd"

const OPTION_BOX = preload("res://ui/screens/Practice/components/OptionBox/OptionBox.tscn")

signal show_select_type_study_pop_up(selected_option, scroll_pos)

onready var _change_deck = $MarginContainer/Layout/ChangeDeck as Control
onready var _option_preview = $MarginContainer/Layout/OptionPreview as Control
onready var _option_scroll = $MarginContainer/Layout/OptionScroll as ScrollContainer
onready var _options_container = $MarginContainer/Layout/OptionScroll/Content as HBoxContainer

var _option_array : Array

func _ready():
	_change_deck.connect("normal_flip", self, "_on_change_deck_pressed")
	_option_preview.connect("option_pressed", self, "_on_option_pressed")
	
	_option_preview.start()
	_option_array = _load_data()
	_insert_option_array()
	
	start()

func start() -> void:
	_update_current_deck()
	_error_suporter()

func _load_data() -> Array:
	var _result_array : Array
	for _o in PRACTICEOPTIONS.options_values:
		_result_array.append(_create_option_box(_o["title"], _o))
	return _result_array

func _create_option_box(var _title: String, var _option: Dictionary) -> Control:
	var _option_box : Control = OPTION_BOX.instance()
	
	_option_box.title = _title
	_option_box.option = _option
	
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

func _on_switch_box_to_front(_option_box: Control) -> void:
	for _o in _option_array:
		if _o == _option_box:
			pass
		else:
			if _o.side == "BACK":
				_o.back_action()

func _on_option_pressed(_option: Dictionary) -> void:
	emit_signal("show_select_type_study_pop_up", _option, _option_scroll.scroll_horizontal)
	_on_switch_box_to_front(null)

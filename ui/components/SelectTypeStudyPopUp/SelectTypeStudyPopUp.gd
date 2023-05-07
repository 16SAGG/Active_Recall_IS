extends Control

signal go_to_flash_card_practice_requested(type, card_count)
signal go_to_test_practice_requested(type, card_count)
signal go_to_memory_practice_requested(type, card_count)

signal hide_select_type_study_pop_up_requested

const OPTIONSHADOWBOX = preload("res://ui/components/SelectTypeStudyPopUp/components/OptionShadowBox/OptionShadowBox.tscn")

export var showed : bool = false setget _setget_showed

onready var animation_player = $AnimationPlayer as AnimationPlayer

onready var _change_deck_title = $Pivot/MarginContainer/Layout/ChangeDeckShadow/MarginContainer/Title as Label
onready var _option_preview = $Pivot/MarginContainer/Layout/OptionPreview as Control
onready var _option_scroll = $Pivot/MarginContainer/Layout/OptionScroll as ScrollContainer
onready var _options_container = $Pivot/MarginContainer/Layout/OptionScroll/Content as HBoxContainer

var _selected_option : Dictionary
var _option_array : Array

func _ready() -> void:
	_option_preview.connect("click_outside", self, "_on_click_outside")
	_option_preview.connect("daily_study_requested", self, "_on_daily_study_requested")
	_option_preview.connect("custom_study_requested", self, "_on_custom_study_requested")
	
	_option_array = _load_data()
	_insert_option_array()
	_update_current_deck()


func start(var _s_option : Dictionary, var _scroll_pos : int) -> void:
	animation_player.play("SHOW")
	_show_option_by_dir(_s_option, _scroll_pos)
	_update_current_deck()
	_option_preview.start(_selected_option)

func _setget_showed(var _showed : bool) -> void:
	showed = _showed
	if _option_preview:
		_option_preview.showed = _showed

func _update_current_deck() -> void:
	if USERDATA.current_deck_data:
		_change_deck_title.text = USERDATA.current_deck_data["title"]

func _load_data() -> Array:
	var _result_array : Array
	
	for _o in PRACTICEOPTIONS.options_values:
		_result_array.append(_create_option_shadow_box(_o["title"], _o["dir"]))
	
	return _result_array

func _create_option_shadow_box(var _title : String, var _dir : String) -> Control:
	var _option_shadow_box : Control = OPTIONSHADOWBOX.instance()
	
	_option_shadow_box.title = _title
	_option_shadow_box.dir = _dir
	
	return _option_shadow_box

func _insert_option_array() -> void:
	for _o in _option_array:
		_options_container.add_child(_o)

func _show_option_by_dir(var _s_option : Dictionary, var _scroll_pos : int) -> void:
	for _o in _options_container.get_children():
		if _o.dir == _s_option["dir"]:
			_o.show()
		else:
			_o.hide()
	
	_option_scroll.scroll_horizontal = _scroll_pos
	_selected_option = _s_option

func _on_click_outside() -> void:
	emit_signal("hide_select_type_study_pop_up_requested")

func _on_daily_study_requested(var _card_count : int ) -> void:
	emit_signal("go_to_" + _selected_option["dir"] + "_practice_requested", "DAILY", _card_count)

func _on_custom_study_requested(var _card_count : int) -> void:
	emit_signal("go_to_" + _selected_option["dir"] + "_practice_requested", "CUSTOM", _card_count)

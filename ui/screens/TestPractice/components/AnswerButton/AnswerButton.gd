extends "res://ui/components/ButtonBase/ButtonBase.gd"

const BODY_1 = preload("res://miscellaneous/fonts/dynamic_fonts/body_1.tres")
const BODY_2 = preload("res://miscellaneous/fonts/dynamic_fonts/body_2.tres")

signal answer_selected(answer)

onready var _front_title = $Pivot/Front/MarginContainer/Title as Label
onready var _back_title = $Pivot/Back/MarginContainer/Title as Label
onready var _back_box = $Pivot/Back/Style/BackgroundBox as Control
onready var _move_to = $MoveTo as AnimationPlayer

var is_correct : bool = false

func set_values(var _answer : String, var _color : String) -> void:
	_text_supervisor(_answer)
	_front_title.text = _answer
	_back_title.text = _answer
	
	var _current_theme = USERDATA.current_theme
	match _color:
		"CORRECT":
			is_correct = true
			_back_box.modulate = THEMES.DICT_THEMES[_current_theme]["PRIMARY"]
		"WRONG":
			is_correct = false
			_back_box.modulate = THEMES.DICT_THEMES[_current_theme]["DANGER"]

func _text_supervisor(var _text : String) -> void:
	if _text.length() < 12:
		_front_title.add_font_override("font", BODY_1)
		_back_title.add_font_override("font", BODY_1)
	else:
		_front_title.add_font_override("font", BODY_2)
		_back_title.add_font_override("font", BODY_2)

func play_move_to(var _direction : String) -> void:
	_move_to.play(_direction)

func _on_FrontTrigger_pressed() -> void:
	if not button_base_player.is_playing() and _button_recharge.is_stopped():
		front_action()
		emit_signal("answer_selected", self)

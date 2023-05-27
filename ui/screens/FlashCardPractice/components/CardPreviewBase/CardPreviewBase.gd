extends MarginContainer

const H2_HEADLINE = preload("res://miscellaneous/fonts/dynamic_fonts/H2_headline.tres")
const H5_HEADLINE = preload("res://miscellaneous/fonts/dynamic_fonts/H5_headline.tres")

signal show_finished

onready var _title_label = $BaseContent/Layout/Title as Label
onready var _next_day_label = $BaseContent/Layout/NextDay as Label
onready var anim_player = $AnimationPlayer as AnimationPlayer

func start() -> void:
	anim_player.play("RESET")

func set_values(var _title : String, var _next_day : int) -> void:
	_title_label.text = _title
	_text_supervisor(_title)
	match _next_day:
		-1: 
			_next_day_label.text = "Bien hecho"
		0:
			_next_day_label.text = "Volverá en un instante"
		1:
			_next_day_label.text = "+ " + str(_next_day) + " día"
		_:
			_next_day_label.text = "+ " + str(_next_day) + " días"

func _text_supervisor(var _text : String) -> void:
	if _text.length() < 12:
		_title_label.add_font_override("font", H2_HEADLINE)
	else:
		_title_label.add_font_override("font", H5_HEADLINE)


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "SHOW":
		emit_signal("show_finished")

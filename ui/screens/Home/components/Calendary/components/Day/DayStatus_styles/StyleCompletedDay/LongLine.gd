extends Control

onready var _current_theme = USERDATA.current_theme as String

func _draw() -> void:
	var _color : String = THEMES.DICT_THEMES[_current_theme]['SECONDARY']
	draw_line(Vector2(16, 30), Vector2(30, 16), _color, 3, true)

extends Control

onready var _current_theme = USERDATA.current_theme as String

func _draw() -> void:
	draw_line(Vector2(0, 62), Vector2(244, 62), THEMES.DICT_THEMES[_current_theme]['PRIMARY'], 1)

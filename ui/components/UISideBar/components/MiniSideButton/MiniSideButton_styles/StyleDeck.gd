extends Control


onready var _current_theme = USERDATA.current_theme as String

func _draw() -> void:
	var _size : Vector2 = rect_size/2
	var _pos : Vector2 = rect_size/4
	draw_rect(Rect2(_pos, _size), Color(THEMES.DICT_THEMES[_current_theme]['PRIMARY']))

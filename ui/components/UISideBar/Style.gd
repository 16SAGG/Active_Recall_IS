extends Control


onready var _current_theme = USERDATA.current_theme as String

func _draw() -> void:
	var _style_box : StyleBoxFlat = StyleBoxFlat.new()
	var _size : Vector2 = rect_size
	var _pos : Vector2 = Vector2(0, 0)
	_style_box.bg_color = Color(0, 0, 0, 0)
	_style_box.border_color = THEMES.DICT_THEMES[_current_theme]['PRIMARY']
	_style_box.border_width_bottom = 0
	_style_box.border_width_top = 0
	_style_box.border_width_left = 0
	_style_box.border_width_right = 1
	_style_box.anti_aliasing = false
	draw_style_box(_style_box, Rect2(_pos, _size))

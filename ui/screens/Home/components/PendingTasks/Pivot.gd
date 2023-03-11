extends Position2D

onready var _current_theme = USERDATA.current_theme as String
onready var _size : Vector2 = get_parent().rect_size
onready var _pos : Vector2 = -get_parent().rect_size/2

func _draw() -> void:
	var _style_box : StyleBoxFlat = StyleBoxFlat.new()
	_style_box.set_corner_radius_all(THEMES.DICT_RADIUS['PRIMARY'])
	_style_box.bg_color = Color(0, 0, 0, 0)
	_style_box.border_color = THEMES.DICT_THEMES[_current_theme]['PRIMARY']
	_style_box.border_width_bottom = 1
	_style_box.border_width_top = 1
	_style_box.border_width_left = 1
	_style_box.border_width_right = 1
	_style_box.anti_aliasing = false
	draw_style_box(_style_box, Rect2(_pos, _size))

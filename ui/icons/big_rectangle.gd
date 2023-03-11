extends Button

onready var _current_theme = USERDATA.current_theme as String

func _draw() -> void:
	var _style_box : StyleBoxFlat  = StyleBoxFlat.new()
	var _size : Vector2 = rect_size
	var _pos : Vector2 = Vector2.ZERO
	_style_box.set_corner_radius_all(THEMES.DICT_RADIUS['PRIMARY'])
	_style_box.bg_color = THEMES.DICT_THEMES[_current_theme]['PRIMARY']
	draw_style_box(_style_box, Rect2(_pos, _size))

extends Control


onready var _current_theme = USERDATA.current_theme as String

func _draw() -> void:
	var _circle : StyleBoxFlat  = StyleBoxFlat.new()
	var _size : Vector2 = rect_size
	var _pos : Vector2 = Vector2.ZERO
	_circle.set_corner_radius_all(THEMES.DICT_RADIUS['ROUNDED'])
	_circle.bg_color = THEMES.DICT_THEMES[_current_theme]['DANGER']
	draw_style_box(_circle, Rect2(_pos, _size))

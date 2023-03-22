#tool
extends Control

const TEST_COLOR = {
	'BLACK': "000000",
	'WHITE': "FFFFFF",
	'GRAY': "D9D9D9",
}

export (String, 'PRIMARY', 'SECONDARY', 'TERTIARY', 'DARK', 'DANGER', 'TRANSLUCENT', 'SHADOW') var background_color = 'PRIMARY'
export (String, 'PRIMARY', 'SECONDARY', 'TERTIARY', 'DARK', 'DANGER', 'TRANSLUCENT', 'SHADOW') var border_color = 'TRANSLUCENT'
export (Array, int, 'None', '5', '10', '15', '20') var corner_radius = [2, 2, 2, 2] #[0]: TOP_LEFT #[1]: TOP_RIGHT #[2]: BOT_LEFT #[3]: BOT_RIGHT
export (Array, int, 'None', '1', '2', '3') var border_width = [0, 0, 0, 0] #[0]: LEFT #[1]: RIGHT #[2]: TOP #[3]: BOTTOM
export (String, 'NONE', 'BLACK', 'WHITE', 'GRAY') var test_background_color = 'NONE'
export (String, 'NONE', 'BLACK', 'WHITE', 'GRAY') var test_border_color = 'NONE'

onready var _current_theme = USERDATA.current_theme as String

func _draw() -> void:
	var _size : Vector2 = rect_size
	var _pos : Vector2 = Vector2.ZERO

	var _style_box : StyleBoxFlat = StyleBoxFlat.new()
	
	match test_background_color:
		'NONE':
			_style_box.bg_color = THEMES.DICT_THEMES[_current_theme][background_color]
		_:
			_style_box.bg_color = TEST_COLOR[test_background_color]
	
	match test_border_color:
		'NONE':
			_style_box.border_color = THEMES.DICT_THEMES[_current_theme][border_color]
		_:
			_style_box.border_color = TEST_COLOR[test_border_color]
	
	_style_box.corner_radius_top_left = corner_radius [0] * 5
	_style_box.corner_radius_top_right = corner_radius [1] * 5
	_style_box.corner_radius_bottom_left = corner_radius [2] * 5
	_style_box.corner_radius_bottom_right = corner_radius [3] * 5
	
	_style_box.border_width_left = border_width [0]
	_style_box.border_width_right = border_width [1]
	_style_box.border_width_top = border_width [2]
	_style_box.border_width_bottom = border_width [3]
	
	_style_box.anti_aliasing = false
	draw_style_box(_style_box, Rect2(_pos, _size))


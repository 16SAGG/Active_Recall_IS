#tool
extends Control

const TEST_COLOR = {
	'BLACK': "000000",
	'WHITE': "FFFFFF",
	'GRAY': "D9D9D9",
}

export (String, 'PRIMARY', 'SECONDARY', 'TERTIARY', 'DARK', 'DANGER', 'TRANSLUCENT', 'SHADOW', 'GRAPH_ITEM_1', 'GRAPH_ITEM_2', 'GRAPH_ITEM_3') var background_color = 'PRIMARY'
export (String, 'PRIMARY', 'SECONDARY', 'TERTIARY', 'DARK', 'DANGER', 'TRANSLUCENT', 'SHADOW', 'GRAPH_ITEM_1', 'GRAPH_ITEM_2', 'GRAPH_ITEM_3') var border_color = 'TRANSLUCENT'
export (int, 40, 400, 40) var corner_radius = 120
export (int, 0, 48, 1) var corner_detail = 12
export (bool) var anti_aliasing = true
export (Array, int, 'NONE', '1', '2', '3', '4', '5', '6') var border_width = [0, 0, 0, 0] #[0]: LEFT #[1]: RIGHT #[2]: TOP #[3]: BOTTOM
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
	
	_style_box.set_corner_radius_all(corner_radius)
	_style_box.corner_detail = corner_detail
	
	_style_box.border_width_left = border_width [0]
	_style_box.border_width_right = border_width [1]
	_style_box.border_width_top = border_width [2]
	_style_box.border_width_bottom = border_width [3]
	
	_style_box.anti_aliasing = true
	draw_style_box(_style_box, Rect2(_pos, _size))


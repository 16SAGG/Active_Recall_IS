#tool
extends Control

const TEST_COLOR = {
	'BLACK': "000000",
	'WHITE': "FFFFFF",
	'GRAY': "D9D9D9",
}

enum color {PRIMARY, SECONDARY, TERTIARY, DARK, DANGER, TRANSLUCENT}

export (String, 'PRIMARY', 'SECONDARY', 'TERTIARY', 'DARK', 'DANGER', 'TRANSLUCENT', 'SHADOW') var background_color = 'PRIMARY'
export (String, 'NONE', 'BLACK', 'WHITE', 'GRAY') var test_background_color = 'NONE'
export (Array, Vector2) var points_multiplier = [Vector2(0, 0.5), Vector2(1, 0), Vector2(1, 1)]

onready var _current_theme = USERDATA.current_theme as String

func _draw() -> void:
	var _size : Vector2 = rect_size
	var _points : Array
	
	for _p in points_multiplier:
		_points.append(_p * rect_size)
	
	var _bg_color : String
	
	match test_background_color:
		'NONE':
			_bg_color = THEMES.DICT_THEMES[_current_theme][background_color]
		_:
			_bg_color = TEST_COLOR[test_background_color]
	
	draw_colored_polygon(PoolVector2Array(_points), _bg_color)

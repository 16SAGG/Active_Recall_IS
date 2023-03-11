extends Control

const LE_MARGIN : Vector2 = Vector2(32, 32)

onready var _current_theme = USERDATA.current_theme as String

func _draw() -> void:
	var _background_box : StyleBoxFlat = StyleBoxFlat.new()
	var _bg_size : Vector2 = rect_size
	var _bg_pos : Vector2 = Vector2.ZERO
	_background_box.set_corner_radius_all(THEMES.DICT_RADIUS['PRIMARY'])
	_background_box.bg_color = THEMES.DICT_THEMES[_current_theme]['PRIMARY']
	draw_style_box(_background_box, Rect2(_bg_pos, _bg_size))
	
	var _line_edit_box : StyleBoxFlat = StyleBoxFlat.new()
	var _le_size : Vector2 = rect_size - LE_MARGIN
	var _le_pos : Vector2 = LE_MARGIN / 2
	_line_edit_box.set_corner_radius_all(THEMES.DICT_RADIUS['ROUNDED'])
	_line_edit_box.bg_color = THEMES.DICT_THEMES[_current_theme]['SECONDARY']
	draw_style_box(_line_edit_box, Rect2(_le_pos, _le_size))

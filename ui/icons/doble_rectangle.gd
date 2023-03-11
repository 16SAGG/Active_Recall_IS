extends Button

onready var _current_theme = USERDATA.current_theme as String

func _draw() -> void:
	var _style_box : StyleBoxFlat  = StyleBoxFlat.new()
	var _style_size : Vector2 = rect_size
	var _style_pos : Vector2 = Vector2.ZERO
	_style_box.set_corner_radius_all(THEMES.DICT_RADIUS['PRIMARY'])
	_style_box.bg_color = THEMES.DICT_THEMES[_current_theme]['PRIMARY']
	draw_style_box(_style_box, Rect2(_style_pos, _style_size))
	
	var _rect_size : Vector2 = rect_size/2
	var _rect_pos : Vector2 = rect_size/4
	draw_rect(Rect2(_rect_pos, _rect_size), Color(THEMES.DICT_THEMES[_current_theme]['SECONDARY']))

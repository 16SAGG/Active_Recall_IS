extends Control


const V_SIZE : float = 56.0
const L_MARGIN : float = 16.0
const R_MARGIN : float = 16.0

onready var _h_size = get_parent().get_parent().rect_size.x - L_MARGIN - R_MARGIN as float
onready var _current_theme = USERDATA.current_theme as String

func _draw() -> void:
	var _style_box : StyleBoxFlat = StyleBoxFlat.new()
	var _size : Vector2 = Vector2(_h_size, V_SIZE)
	var _pos : Vector2 = Vector2(L_MARGIN, 0)
	_style_box.set_corner_radius_all(THEMES.DICT_RADIUS['PRIMARY'])
	_style_box.bg_color = Color(0, 0, 0, 0)
	_style_box.border_color = THEMES.DICT_THEMES[_current_theme]['PRIMARY']
	_style_box.border_width_bottom = 1
	_style_box.border_width_top = 1
	_style_box.border_width_left = 1
	_style_box.border_width_right = 1
	_style_box.anti_aliasing = false
	draw_style_box(_style_box, Rect2(_pos, _size))

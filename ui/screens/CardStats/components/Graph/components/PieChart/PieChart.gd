extends Control

export var item_value : Array= [
		{"color": "9AFAA4", "percent": 180},
		{"color": "9ACCFA", "percent": 90},
		{"color": "E19AFA", "percent": 90},
	]

onready var _current_theme = USERDATA.current_theme as String

func _draw() -> void:
	var _max_radius : float = 0
	if self.rect_size.y >= self.rect_size.x:
		_max_radius = self.rect_size.x / 2
	else:
		_max_radius = self.rect_size.y / 2
		
	var _percentage_traveled : float = 0
	
	for _i_v in item_value:
		var _item_percent : float = _i_v["percent"]
		var _item_color : String = _i_v["color"]
		draw_circle_arc_poly(self.rect_size / 2, 
		_max_radius,
		 _percentage_traveled,
		 _percentage_traveled + _item_percent,
		 _item_color)
		
		_percentage_traveled += _item_percent
	
	var _small_circle_radius : float = _max_radius * 0.65
	draw_circle_arc_poly(self.rect_size / 2,
	 _small_circle_radius, 
	0, 360, THEMES.DICT_THEMES[_current_theme]['SECONDARY'])

func draw_circle_arc_poly(var _center : Vector2, 
var _radius : float, 
var _angle_from : float, var _angle_to : float, var _new_color : String) -> void:
	
	var _nb_points = 32
	var _points_arc = PoolVector2Array()
	_points_arc.push_back(_center)
	var _colors = PoolColorArray([_new_color])

	for i in range(_nb_points + 1):
		var _angle_point = deg2rad(_angle_from + i * (_angle_to - _angle_from) / _nb_points - 90)
		_points_arc.push_back(_center + Vector2(cos(_angle_point), sin(_angle_point)) * _radius)
	draw_polygon(_points_arc, _colors)

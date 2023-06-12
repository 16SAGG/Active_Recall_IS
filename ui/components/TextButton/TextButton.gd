extends "res://ui/components/ButtonBase/ButtonBase.gd"


export var _new_title : String = "Title"
export var _new_size : Vector2 = Vector2(178, 56)

export var activate_basic_border : bool = false

onready var _title = $Pivot/Front/MarginContainer/Title as Label
onready var _background_box = $Pivot/Front/Style/BackgroundBox as Control

func _ready() -> void:
	_title.text = _new_title
	fit_size(_new_size)
	_border(activate_basic_border)

func _border(var _activate : bool) -> void:
	match _activate:
		true:
			_background_box.background_color = "SECONDARY"
			_background_box.border_color = "PRIMARY"
			_background_box.border_width = [2, 2, 2, 2]

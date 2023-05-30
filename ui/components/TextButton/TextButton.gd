extends "res://ui/components/ButtonBase/ButtonBase.gd"


export var _new_title : String = "Title"
export var _new_size : Vector2 = Vector2(178, 56)

onready var _title = $Pivot/Front/MarginContainer/Title as Label

func _ready() -> void:
	_title.text = _new_title
	fit_size(_new_size)

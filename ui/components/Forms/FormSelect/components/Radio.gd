extends "res://ui/components/ButtonBase/ButtonBase.gd"


export var _new_value : bool = true

func _ready():
	if _new_value:
		_front.visible = true
		_back.visible = false
	else:
		_front.visible = false
		_back.visible = true
	
	fit_size(Vector2(144, 64))

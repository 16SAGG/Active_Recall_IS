extends "res://ui/components/ButtonBase/ButtonBase.gd"

export var new_status : bool = true setget _setget_new_status

func _ready():
	if new_status:
		_front.visible = true
		_back.visible = false
	else:
		_front.visible = false
		_back.visible = true
	
	fit_size(Vector2(144, 64))

func _setget_new_status(var _new_status : bool) -> void:
	if _new_status:
		if _front:
			_front.visible = true
		if _back:
			_back.visible = false
	else:
		if _front:
			_front.visible = false
		if _back:
			_back.visible = true

extends "res://ui/components/ButtonBase/ButtonBase.gd"

onready var _title = $Pivot/Front/MarginContainer/Title as Label

func _set_title(var _new_title : String) -> void:
	_title.text = _new_title

func restart() -> void:
	if USERDATA.current_user_data:
		_set_title(USERDATA.current_user_data["name"] + " " + USERDATA.current_user_data["last_name"])
	_front.visible = true
	_back.visible = false

extends "res://ui/components/ButtonBase/ButtonBase.gd"

signal option_pressed(option)

onready var _title_label = $Pivot/Front/MarginContainer/Title

var _option : Dictionary

func set_values(var _opt : Dictionary) ->void:
	_title_label.text = _opt["title"]
	
	_option = _opt

func _on_BackTrigger_pressed() -> void:
	emit_signal("option_pressed", _option)

extends "res://ui/components/ButtonBase/ButtonBase.gd"

onready var _title_label = $Pivot/Front/MarginContainer/Title

func set_values(var _title : String) ->void:
	_title_label.text = _title

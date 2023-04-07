extends "res://ui/components/ButtonBase/ButtonBase.gd"

export var title = ""

onready var _title = $Pivot/Front/MarginContainer/Title as Label

func _ready() -> void:
	_set_title(title)

func _set_title(new_title : String) -> void:
	_title.text = new_title

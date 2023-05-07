extends "res://ui/components/ButtonBase/ButtonBase.gd"

# warning-ignore:unused_signal
signal option_pressed(option)

onready var _front_title = $Pivot/Front/MarginContainer/Title as Label

onready var _back_title = $Pivot/Back/MarginContainer/Title as Label

var title : String
var option : Dictionary

func _ready() -> void:
	_set_values(title)

func _set_values(var _title : String) -> void:
	_front_title.text = _title
	
	_back_title.text = _title

func _on_BackTrigger_pressed() -> void:
	emit_signal("option_pressed", option)

extends "res://ui/components/ButtonBase/ButtonBase.gd"

# warning-ignore:unused_signal
signal pressed(deck)

onready var _title_front : Label = $Pivot/Front/MarginContainer/Title
onready var _title_back : Label = $Pivot/Back/MarginContainer/Title

var title : String
var id : int

func _ready():
	_set_values(title)

func _set_values(_title : String) -> void:
	_title_front.text = _title
	_title_back.text = _title

func _on_BackTrigger_pressed():
	emit_signal("pressed", self)

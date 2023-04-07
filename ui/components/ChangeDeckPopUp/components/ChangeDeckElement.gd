extends "res://ui/components/ButtonBase/ButtonBase.gd"

signal pressed(deck)

onready var _title_front : Label = $Pivot/Front/MarginContainer/Title
onready var _title_back : Label = $Pivot/Back/MarginContainer/Title
onready var _go_to = $GoTo as Button

var title : String
var id : int

func _ready():
	_set_values(title)

func _set_values(_title : String) -> void:
	_title_front.text = _title
	_title_back.text = _title

func _on_GoTo_pressed() -> void:
	emit_signal("pressed", self)

func back_action() -> void:
	_trigger.visible = true
	_go_to.visible = false
	button_base_player.play("FLIP_TO_FRONT") 

# warning-ignore:unused_argument
func _on_ChangeDeckElement_back_flip(button):
	_trigger.visible = false
	_go_to.visible = true

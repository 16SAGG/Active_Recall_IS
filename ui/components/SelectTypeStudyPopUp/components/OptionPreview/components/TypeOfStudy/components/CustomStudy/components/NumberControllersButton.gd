extends Control

const DOWN_ARROW = preload("res://miscellaneous/image/icons/SMALL_ARROW_DOWN.png")

signal clicked

export (String, "UP", "DOWN") var _type = "UP"

onready var _trigger = $Trigger as Button


func _ready() -> void:
	match _type: 
		"UP":
			pass
		_:
			_trigger.icon = DOWN_ARROW

func _on_Trigger_pressed():
	emit_signal("clicked")

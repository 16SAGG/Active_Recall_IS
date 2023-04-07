extends "res://ui/components/ButtonBase/ButtonBase.gd"

onready var _front_flip_button = $Pivot/Front/MarginContainer/Content/FlipButton/Button as Control
onready var _back_flip_button = $Pivot/Back/MarginContainer/Content/FlipButton/Button as Control

func _ready() -> void:
	_front_flip_button.connect("pressed", self, "_on_front_flip_button_pressed")
	_back_flip_button.connect("pressed", self, "_on_back_flip_button_pressed")

func _on_front_flip_button_pressed() -> void:
	front_action()
	print("FRONT")

func _on_back_flip_button_pressed() -> void:
	back_action()
	print("BACK")

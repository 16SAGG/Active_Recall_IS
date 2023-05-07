extends Control

signal clicked

onready var _icon_group = $Style/Icon

onready var _right_icon = $Style/Icon/Right
onready var _left_icon = $Style/Icon/Left
onready var _wrong_icon = $Style/Icon/Wrong
onready var _correct_icon = $Style/Icon/Correct

func set_icon(var _icon_name : String )-> void:
	for _i in _icon_group.get_children():
		_i.visible = false
	
	match _icon_name:
		"RIGHT":
			_right_icon.visible = true
		"LEFT":
			_left_icon.visible = true
		"WRONG":
			_wrong_icon.visible = true
		"CORRECT":
			_correct_icon.visible = true

func _on_Trigger_pressed():
	emit_signal("clicked")

extends Control

onready var _animation_player = $AnimationPlayer as AnimationPlayer

var _image_button : Button
var _image_showed : bool = false

func _ready() -> void:
	match name:
		"BackLine":
			_image_button = get_node("MarginContainer/Content/HBoxContainer/Image/IMGButton")
		"FrontLine":
			_image_button = get_node("MarginContainer/Content/Image/IMGButton")
	
# warning-ignore:return_value_discarded
	_image_button.connect("pressed", self, "_on_IMGButton_pressed")

func show_image () -> void :
	if not _image_showed:
		_image_showed = true
		_animation_player.play("SHOW_IMAGE")

func hide_image () -> void :
	if _image_showed:
		_image_showed = false
		_animation_player.play("HIDE_IMAGE")

func _on_IMGButton_pressed () -> void:
	hide_image() 

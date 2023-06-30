extends Control

export (bool) var _flip_icon = false

onready var _icon = $Style/Icon as TextureRect

func _ready() -> void:
	_icon.flip_v = _flip_icon

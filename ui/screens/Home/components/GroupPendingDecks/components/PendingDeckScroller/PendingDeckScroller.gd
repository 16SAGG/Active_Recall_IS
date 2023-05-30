extends Control

onready var anim_player = $AnimationPlayer as AnimationPlayer
onready var trigger = $Trigger as Button
onready var _pivot = $Style/Pivot as Position2D

var mouse_on : bool = false

func _ready() -> void:
	match self.name:
		"PDScrollerUp":
			_pivot.position = Vector2(32, 28)
			_pivot.rotation_degrees = 0
		"PDScrollerDown":
			_pivot.position = Vector2(32, 36)
			_pivot.rotation_degrees = 180

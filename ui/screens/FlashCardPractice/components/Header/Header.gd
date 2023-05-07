extends Label

onready var _animation_player = $AnimationPlayer as AnimationPlayer

var _new_text : String

func change_text (var text : String) -> void:
	_new_text = text
	_animation_player.play("CHANGE_TEXT")

func _set_text_with_new_text() -> void: #This method start using the AnimationPlayer
	self.text = _new_text 

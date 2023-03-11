extends Control

onready var _anim_player = $AnimationPlayer as AnimationPlayer

func _on_Trigger_pressed() -> void:
	if not _anim_player.is_playing():
		_anim_player.play("CLICKED")

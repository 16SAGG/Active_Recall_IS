extends Control

onready var _button_base_player = $ButtonBasePlayer as AnimationPlayer

func _on_Trigger_pressed():
	if not _button_base_player.is_playing():
		_button_base_player.play("FLIP")


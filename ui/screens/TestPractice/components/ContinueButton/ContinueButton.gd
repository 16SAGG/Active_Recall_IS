extends Control

signal continue_pressed

onready var anim_player = $AnimationPlayer as AnimationPlayer

func _on_Trigger_pressed():
	anim_player.play("HIDE")
	emit_signal("continue_pressed")

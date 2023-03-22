extends Control

signal normal_flip
signal back_flip
signal front_flip

export (bool) var has_back = false
export (String, "FRONT", "BACK") var side = "FRONT"

onready var button_base_player = $ButtonBasePlayer as AnimationPlayer
onready var _button_recharge = $ButtonRecharge

func flip_action() -> void:
	button_base_player.play("FLIP")

func front_action() -> void:
	button_base_player.play("FLIP_TO_BACK")

func back_action() -> void:
	button_base_player.play("FLIP_TO_FRONT") 

func _on_Trigger_pressed() -> void:
	if not button_base_player.is_playing() and _button_recharge.is_stopped():
		match has_back:
			true:
				match side:
					"FRONT":
						front_action()
					"BACK":
						back_action()
			false:
				flip_action()


func _on_ButtonBasePlayer_animation_finished(anim_name) -> void:
	_button_recharge.start()
	match anim_name:
		"FLIP":
			emit_signal("normal_flip")
		"FLIP_TO_BACK":
			emit_signal("back_flip")
		"FLIP_TO_FRONT":
			emit_signal("front_flip")

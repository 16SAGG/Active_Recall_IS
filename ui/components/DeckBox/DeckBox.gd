extends "res://ui/components/ButtonBase/ButtonBase.gd"

signal box_flip(deck)
signal deck_pressed(deck, screen)

export (String, "deck", "practice") var _destination = "deck"


onready var _flip_timer_player = $FlipTimerPlayer as AnimationPlayer
onready var _trigger = $Trigger as Button
onready var _go_to = $GoTo as Button


func _on_GoTo_pressed() -> void:
	emit_signal("deck_pressed", self, _destination)

func back_action() -> void:
	_trigger.visible = true
	_go_to.visible = false
	_flip_timer_player.stop()
	button_base_player.play("FLIP_TO_FRONT") 

func _on_DeckBox_back_flip() -> void:
	_trigger.visible = false
	_go_to.visible = true
	_flip_timer_player.play("FLIP_TIMER")
	emit_signal("box_flip", self)

func _on_FlipTimerPlayer_animation_finished(anim_name) -> void:
	if anim_name == "FLIP_TIMER":
		back_action()



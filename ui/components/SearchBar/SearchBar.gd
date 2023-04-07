extends "res://ui/components/ButtonBase/ButtonBase.gd"

signal search(text)

onready var _search_container = $Pivot/Back/Style/SearchContainer as Control
onready var _search_line = $Pivot/Back/MarginContainer/SearchLine as LineEdit
onready var _flip_timer_player = $FlipTimerPlayer as AnimationPlayer


func _on_SearchLine_text_changed(new_text) -> void:
	_flip_timer_player.stop()
	_flip_timer_player.play("FLIP_TIMER")
	
	emit_signal("search", new_text)
	
	var _unused_vars = [new_text] #To avoid warnings

func back_action() -> void:
	_trigger.visible = true
	_flip_timer_player.stop()
	button_base_player.play("FLIP_TO_FRONT") 

func _on_SearchBar_back_flip(_button : Control) -> void:
	_trigger.visible = false
	_flip_timer_player.play("FLIP_TIMER")
	_search_line.grab_focus()

func _on_FlipTimerPlayer_animation_finished(anim_name) -> void:
	if anim_name == "FLIP_TIMER":
		back_action()



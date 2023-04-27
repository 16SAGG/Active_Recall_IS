extends "res://ui/components/ButtonBase/ButtonBase.gd"

signal search(text)

onready var _search_line = $Pivot/Back/MarginContainer/SearchLine as LineEdit

func _on_SearchLine_text_changed(new_text):
	flip_timer_player.stop()
	flip_timer_player.play("FLIP_TIMER")
	emit_signal("search", new_text)

extends Control

signal clicked

func _on_Trigger_pressed():
	emit_signal("clicked")

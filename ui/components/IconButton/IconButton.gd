extends Control

signal button_down

export var _new_symbol : String = ">"

onready var _symbol = $Symbol as Label

func _ready() -> void:
	if _symbol.text != "":
		_symbol.text = _new_symbol

func _on_Trigger_button_down():
	emit_signal("button_down")

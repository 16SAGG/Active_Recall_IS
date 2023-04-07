extends Control

signal new_deck(title)
signal hide_new_deck_pop_up_requested

export var showed : bool = false

onready var animation_player = $AnimationPlayer as AnimationPlayer

onready var _mouse_detector = $MouseDetector as Control
onready var _ok_button = $Pivot/MarginContainer/Layout/Content/OkButton as Control
onready var _new_title = $Pivot/MarginContainer/Layout/Content/NewTitle as LineEdit

func _ready() -> void:
	_ok_button.connect("normal_flip", self, "_on_ok_button_pressed")
	_mouse_detector.connect("click_outside", self, "_on_click_outside")

func _on_ok_button_pressed(_button : Control) -> void:
	emit_signal("new_deck", _new_title.text)

func _on_click_outside() -> void:
	emit_signal("hide_new_deck_pop_up_requested")

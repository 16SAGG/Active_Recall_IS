extends Control

signal go_to_new_card_screen_requested(card)
signal go_to_new_deck_pop_up_requested
signal hide_action_pop_up_requested

export var showed : bool = false setget _setget_showed

onready var animation_player = $AnimationPlayer as AnimationPlayer
onready var _mouse_detector = $MouseDetector as Control
onready var _card_button = $PopUp/Layout/MarginContainer/Content/Card as Control
onready var _deck_button = $PopUp/Layout/MarginContainer/Content/Deck as Control

func _ready() -> void:
	_card_button.connect("normal_flip", self, "_on_card_button_pressed")
	_deck_button.connect("normal_flip", self, "_on_deck_button_pressed")
	_mouse_detector.connect("click_outside", self, "_on_click_outside")

func _setget_showed(var _showed : bool) -> void:
	showed = _showed
	if _mouse_detector:
		_mouse_detector.active = _showed

# warning-ignore:unused_argument
func _on_card_button_pressed(_button : Control) -> void:
	emit_signal("go_to_new_card_screen_requested", Dictionary())

# warning-ignore:unused_argument
func _on_deck_button_pressed(_button : Control) -> void:
	emit_signal("go_to_new_deck_pop_up_requested")

func _on_click_outside() -> void:
	emit_signal("hide_action_pop_up_requested")

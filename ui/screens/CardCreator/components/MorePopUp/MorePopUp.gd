extends Control

signal delete_card_requested
signal hide_more_pop_up_requested

export var showed : bool = false setget _setget_showed

onready var animation_player = $AnimationPlayer as AnimationPlayer
onready var _mouse_detector = $MouseDetector as Control
onready var _delete_button = $PopUp/Layout/MarginContainer/Content/Delete as Control
onready var _info_button = $PopUp/Layout/MarginContainer/Content/Information as Control

func _ready() -> void:
	_delete_button.connect("normal_flip", self, "_on_delete_button_pressed")
	_info_button.connect("normal_flip", self, "_on_info_button_pressed")
	_mouse_detector.connect("click_outside", self, "_on_click_outside")

func _setget_showed(var _showed : bool) -> void:
	showed = _showed
	if _mouse_detector:
		_mouse_detector.active = _showed

# warning-ignore:unused_argument
func _on_delete_button_pressed(_button : Control) -> void:
	emit_signal("delete_card_requested")

# warning-ignore:unused_argument
func _on_info_button_pressed(_button : Control) -> void:
	pass

func _on_click_outside() -> void:
	emit_signal("hide_more_pop_up_requested")

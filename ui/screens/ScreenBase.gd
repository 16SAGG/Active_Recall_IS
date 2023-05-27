extends Control

signal change_deck_requested(button)

onready var _error_change_deck = $ErrorMessage/ChangeDeck as Control
onready var _margin_container = $MarginContainer as MarginContainer
onready var _error_message = $ErrorMessage as MarginContainer
onready var _congrats_message = $CongratulationsMessage as Control

func _ready() -> void:
	_error_change_deck.connect("normal_flip", self, "_on_error_change_deck_pressed")

func _error_suporter() -> void:
	if USERDATA.current_deck_data:
		for _c in self.get_children():
			if _c.name != "CongratulationsMessage":
				_c.visible = true
		
		_error_message.visible = false
	else:
		for _c in self.get_children():
			_c.visible = false
		
		_error_message.visible = true

func _congrats_suporter(var _show : bool) -> void:
	match _show:
		true:
			_congrats_message.animation_player.play("SHOW")
		false:
			_congrats_message.animation_player.play("RESET")

func _on_error_change_deck_pressed(_button : Control) -> void:
	emit_signal("change_deck_requested", _button)

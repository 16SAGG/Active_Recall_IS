extends Control

signal go_to_home_screen_requested
signal show_action_popup_requested
signal go_to_deck_screen_requested
signal go_to_practice_screen_requested
signal go_to_statistics_screen_requested
signal go_to_settings_screen_requested

onready var _logo_button = $MarginController/Content/Logo as Button
onready var _action_button = $MarginController/Content/Action as Button
onready var _home_button = $MarginController/Content/Home as Button
onready var _deck_button = $MarginController/Content/Deck as Button
onready var _practice_button = $MarginController/Content/Practice as Button
onready var _statistics_button = $MarginController/Content/Statistics as Button
onready var _settings_button = $MarginController/Content/Settings as Button

onready var _selector_rect = $MarginController/SelectorRect as Position2D

func _ready() -> void:
	_logo_button.connect("pressed", self, "_on_home_pressed")
	_action_button.connect("pressed", self, "_on_action_pressed")
	_home_button.connect("pressed", self, "_on_home_pressed")
	_deck_button.connect("pressed", self, "_on_deck_pressed")
	_practice_button.connect("pressed", self, "_on_practice_pressed")
	_statistics_button.connect("pressed", self, "_on_statistics_pressed")
	_settings_button.connect("pressed", self, "_on_settings_pressed")

func _on_home_pressed() -> void:
	if _selector_rect.anim_ready:
		emit_signal("go_to_home_screen_requested")
		_selector_rect.go_to('HOME')

func _on_action_pressed() -> void:
	if _selector_rect.anim_ready:
		emit_signal("show_action_popup_requested")
		_selector_rect.go_to('HOME')

func _on_deck_pressed() -> void:
	if _selector_rect.anim_ready:
		emit_signal("go_to_deck_screen_requested")
		_selector_rect.go_to('DECK')

func _on_practice_pressed() -> void:
	if _selector_rect.anim_ready:
		emit_signal("go_to_practice_screen_requested")
		_selector_rect.go_to('PRACTICE')

func _on_statistics_pressed() -> void:
	if _selector_rect.anim_ready:
		emit_signal("go_to_statistics_screen_requested")
		_selector_rect.go_to('STATS')

func _on_settings_pressed() -> void:
	if _selector_rect.anim_ready:
		emit_signal("go_to_settings_screen_requested")
		_selector_rect.go_to('SETTINGS')

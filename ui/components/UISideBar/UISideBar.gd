extends Control

signal go_to_home_screen_requested
signal show_action_pop_up_requested
signal go_to_deck_screen_requested(deck)
signal go_to_practice_screen_requested(deck)
signal go_to_statistics_screen_requested(deck)
signal go_to_settings_screen_requested(deck)

onready var _logo_button = $MarginController/Content/Logo/Button
onready var _action_button = $MarginController/Content/Action/Button as Button
onready var _home_button = $MarginController/Content/Home/Button as Button
onready var _deck_button = $MarginController/Content/Deck/Button as Button
onready var _practice_button = $MarginController/Content/Practice/Button as Button
onready var _statistics_button = $MarginController/Content/Stats/Button as Button
onready var _settings_button = $MarginController/Content/Settings/Button as Button


func _ready() -> void:
	_logo_button.connect("pressed", self, "_on_home_pressed")
	_action_button.connect("pressed", self, "_on_action_pressed")
	_home_button.connect("pressed", self, "_on_home_pressed")
	_deck_button.connect("pressed", self, "_on_deck_pressed")
	_practice_button.connect("pressed", self, "_on_practice_pressed")
	_statistics_button.connect("pressed", self, "_on_statistics_pressed")
	_settings_button.connect("pressed", self, "_on_settings_pressed")

func _on_home_pressed() -> void:
	emit_signal("go_to_home_screen_requested")

func _on_action_pressed() -> void:
	emit_signal("show_action_pop_up_requested")

func _on_deck_pressed() -> void:
	emit_signal("go_to_deck_screen_requested", null)

func _on_practice_pressed() -> void:
	emit_signal("go_to_practice_screen_requested", null)

func _on_statistics_pressed() -> void:
	emit_signal("go_to_statistics_screen_requested", null)

func _on_settings_pressed() -> void:
	emit_signal("go_to_settings_screen_requested", null)

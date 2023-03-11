extends Control

onready var _ui_side_bar = $Layout/UISideBar as Control

func _ready() -> void:
	_ui_side_bar.connect("go_to_home_screen_requested", self, "on_home_requested")
	_ui_side_bar.connect("go_to_deck_screen_requested", self, "on_deck_requested")
	_ui_side_bar.connect("go_to_practice_screen_requested", self, "on_practice_requested")
	_ui_side_bar.connect("go_to_statistics_screen_requested", self, "on_statistics_requested")
	_ui_side_bar.connect("go_to_settings_screen_requested", self, "on_settings_requested")

func on_home_requested() -> void:
	pass

func on_deck_requested() -> void:
	pass

func on_practice_requested() -> void:
	pass

func on_statistics_requested() -> void:
	pass

func on_settings_requested() -> void:
	pass

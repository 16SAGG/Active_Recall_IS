extends Control

signal edit_deck
# warning-ignore:unused_signal
signal go_to_user_settings
# warning-ignore:unused_signal
signal go_to_deck_settings

export var _left_direction : String = "user_settings"
export var _right_direction : String = "user_settings"

onready var _save_button = $MarginContainer/Content/Layout/SaveButton as Control
onready var _left_button = $MarginContainer/Content/Layout/LeftButton as Control
onready var _right_button = $MarginContainer/Content/Layout/RightButton as Control


# warning-ignore:unused_argument
func _on_SaveButton_normal_flip(button) -> void:
	emit_signal("edit_deck")

func _on_LeftButton_button_down() -> void:
	emit_signal("go_to_" + _left_direction)

func _on_RightButton_button_down() -> void:
	emit_signal("go_to_" + _right_direction)

extends "res://ui/screens/ScreenBase.gd"

signal go_to_log_in_screen_requested (button)
signal new_user(user)

onready var _new_name_input = $MarginContainer/Content/Layout/NewNameInput as MarginContainer
onready var _new_last_name_input = $MarginContainer/Content/Layout/NewLastNameInput as MarginContainer
onready var _new_email_input = $MarginContainer/Content/Layout/NewEmailInput as MarginContainer
onready var _new_password_input = $MarginContainer/Content/Layout/NewPasswordInput as MarginContainer
onready var _back_button = $MarginContainer/Content/Layout/Footer/Layout/BackButton as Control
onready var _create_buton = $MarginContainer/Content/Layout/Footer/Layout/CreateButton as Control

func start() -> void:
	_restart_values()

func _restart_values () -> void:
	_new_name_input.restart()
	_new_last_name_input.restart()
	_new_email_input.restart()
	_new_password_input.restart()

func _on_BackButton_button_down() -> void:
	emit_signal("go_to_log_in_screen_requested", null)

# warning-ignore:unused_argument
func _on_CreateButton_normal_flip(button) -> void:
	_new_name_input.set_color("PRIMARY")
	_new_last_name_input.set_color("PRIMARY")
	_new_email_input.set_color("PRIMARY")
	_new_password_input.set_color("PRIMARY")
	
	var _new_name_value : String = TEXTFORMAT.remove_unnecessary_space(_new_name_input.value)
	var _name_is_valid : bool = false
	
	var _new_last_name_value : String = TEXTFORMAT.remove_unnecessary_space(_new_last_name_input.value)
	var _last_name_is_valid : bool = false
	
	var _new_email_value : String = TEXTFORMAT.email_format(_new_email_input.value)
	var _email_is_valid : bool = false
	
	var _new_password_value : String = TEXTFORMAT.password_format(_new_password_input.value, _new_password_input.min_password)
	var _password_is_valid : bool = false
	
	if _new_name_value != "":
		_name_is_valid = true
	else:
		_new_name_input.set_color("DANGER")
	
	if _new_last_name_value != "":
		_last_name_is_valid = true
	else:
		_new_last_name_input.set_color("DANGER")
	
	if _new_email_value != "invalid_email":
		_email_is_valid = true
	else:
		_new_email_input.set_color("DANGER")
	
	if _new_password_value != "invalid_password":
		_password_is_valid = true
	else:
		_new_password_input.set_color("DANGER")
	
	if _name_is_valid and _last_name_is_valid and _email_is_valid and _password_is_valid:
		var _new_user : Dictionary = {
			"name" : _new_name_value,
			"last_name" : _new_last_name_value,
			"email" : _new_email_value,
			"password" : _new_password_value,
			"current_theme" : "DEFAULT",
		}
		
		emit_signal("new_user", _new_user)
		emit_signal("go_to_log_in_screen_requested", null)

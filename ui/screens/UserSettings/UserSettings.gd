extends "res://ui/screens/ScreenBase.gd"

signal go_to_log_in_requested
signal go_to_deck_settings_requested

signal edit_user(user_settings)
signal delete_user

onready var _user_button = $MarginContainer/Layout/UserButton as Control
onready var _scroll_container = $MarginContainer/Layout/ScrollContainer as ScrollContainer
onready var _new_name_input = $MarginContainer/Layout/ScrollContainer/Content/NewNameInput as MarginContainer
onready var _new_last_name_input = $MarginContainer/Layout/ScrollContainer/Content/NewLastNameInput as MarginContainer
onready var _new_email_input = $MarginContainer/Layout/ScrollContainer/Content/NewEmail as MarginContainer
onready var _new_password_input = $MarginContainer/Layout/ScrollContainer/Content/NewPassword as MarginContainer
onready var _delete_button = $MarginContainer/Layout/ScrollContainer/Content/DeleteButton/DeleteButton as Control

func start() -> void:
	_restart_values()

func _restart_values () -> void:
	_user_button.restart()
	_new_name_input.restart()
	_new_last_name_input.restart()
	_new_email_input.restart()
	_new_password_input.restart()
	_delete_button.restart()
	_scroll_container.scroll_vertical = 0

func _on_Footer_edit_deck():
	var _new_user_data : Dictionary = USERDATA.current_user_data.duplicate()
	var _new_name_value : String = TEXTFORMAT.remove_unnecessary_space(_new_name_input.value)
	var _new_last_name_value : String = TEXTFORMAT.remove_unnecessary_space(_new_last_name_input.value)
	var _new_email_value : String = TEXTFORMAT.remove_unnecessary_space(_new_email_input.value)
	var _new_password_value : String = TEXTFORMAT.remove_unnecessary_space(_new_password_input.value)
	
	if _new_name_value != "":
		_new_user_data["name"] = _new_name_value
		_new_name_input.set_color("PRIMARY")
		_new_name_input.restart()
	
	if _new_last_name_value != "":
		_new_user_data["last_name"] = _new_last_name_value
		_new_last_name_input.set_color("PRIMARY")
		_new_last_name_input.restart()
	
	if _new_email_value != "":
		var _email_format = TEXTFORMAT.email_format(_new_email_value)
		if _email_format != "invalid_email":
			_new_user_data["email"] = _email_format
			_new_email_input.set_color("PRIMARY")
			_new_email_input.restart()
		else:
			_new_email_input.set_color("DANGER")
			print("EMAIL INVALIDO")
	
	if _new_password_value != "":
		var _password_format = TEXTFORMAT.password_format(_new_password_value, _new_password_input.min_password)
		if _password_format != "invalid_password":
			_new_user_data["password"] = _password_format
			_new_password_input.set_color("PRIMARY")
			_new_password_input.restart()
		else:
			_new_password_input.set_color("DANGER")
			print("CONTRASEÑA INVALIDO")
	
	emit_signal("edit_user", _new_user_data)
	_user_button.restart()

func _on_Footer_go_to_deck_settings():
	if USERDATA.current_deck_data:
		emit_signal("go_to_deck_settings_requested", null)

func _on_UserButton_front_flip(button):
	emit_signal("go_to_log_in_requested",null)

func _on_DeleteButton_front_flip(button):
	emit_signal("delete_user")

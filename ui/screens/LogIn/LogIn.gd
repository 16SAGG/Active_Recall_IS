extends "res://ui/screens/ScreenBase.gd"

signal go_to_create_user_screen_requested (button)
signal user_entering(user_id)

onready var _email_input = $MarginContainer/Content/Layout/EmailInput as MarginContainer
onready var _password_input = $MarginContainer/Content/Layout/PasswordInput as MarginContainer
onready var _create_user_button = $MarginContainer/Content/Layout/CreateUserButton/CreateUserButton as Control
onready var _enter_button = $MarginContainer/Content/Layout/EnterButton/EnterButton as Control

func _ready() -> void:
	start()

func start() -> void:
	USERDATA.set_users_data()
	_restart_values()

func _restart_values () -> void:
	_email_input.restart()
	_password_input.restart()

# warning-ignore:unused_argument
func _on_CreateUserButton_normal_flip(button)-> void:
	emit_signal("go_to_create_user_screen_requested", null)

# warning-ignore:unused_argument
func _on_EnterButton_normal_flip(button) -> void:
	_email_input.set_color("PRIMARY")
	_password_input.set_color("PRIMARY")
	
	var _email_value : String = TEXTFORMAT.remove_unnecessary_space(_email_input.value)
	var _password_value : String = TEXTFORMAT.remove_unnecessary_space(_password_input.value)
	var _user_id : int
	var _email_is_valid = false
	
	for _u in USERDATA.users_data:
		if _u["email"] == _email_value and _u["password"] == _password_value:
			_user_id = _u["user_id"]
			break
		elif _u["email"] == _email_value:
			_email_is_valid = true
	
	if _user_id:
		emit_signal("user_entering", _user_id)
	elif not _email_is_valid:
		_email_input.set_color("DANGER")
	else:
		_password_input.set_color("DANGER")

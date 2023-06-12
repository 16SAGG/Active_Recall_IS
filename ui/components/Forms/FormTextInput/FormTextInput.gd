extends MarginContainer

export var new_placeholder : String = "Title"
export var password_mode : bool = false
export var min_password : int = 8
export var max_password : int = 12

onready var _content = $Content/Content as LineEdit
onready var _background = $Style/BackgroundBox as Control

var value : String = ""

func _ready() -> void:
	set_color("PRIMARY")
	_content.placeholder_text = new_placeholder
	_set_password_mode(password_mode)

func _set_password_mode(var _activate : bool) -> void:
	if _activate:
		_content.secret = true
		_content.max_length = max_password

func set_color(var _color : String) -> void:
	match _color:
		"PRIMARY":
			_background.modulate = "CFEBCE"
		"DANGER":
			_background.modulate = "EBD0CE"

func restart() -> void:
	set_color("PRIMARY")
	value = ""
	_content.text = ""

func _on_Content_text_changed(new_text):
	value = new_text

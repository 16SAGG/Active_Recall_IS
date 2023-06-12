extends MarginContainer

export var new_title : String = "Title"

onready var _title = $Layout/Title as Label
onready var _radio = $Layout/Radio as Control

var new_status : bool = true setget _setget_new_status
var value : String = "ACTIVE"

func _ready() -> void:
	_title.text = new_title

func _setget_new_status(var _new_status : bool) -> void:
	_radio.new_status = _new_status
	if _new_status:
		value = "ACTIVE"
	else:
		value = "DEACTIVE"

# warning-ignore:unused_argument
func _on_Radio_front_flip(button):
	_setget_new_status(true)

# warning-ignore:unused_argument
func _on_Radio_back_flip(button):
	_setget_new_status(false)

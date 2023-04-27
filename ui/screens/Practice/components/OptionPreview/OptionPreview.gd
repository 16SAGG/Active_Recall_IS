extends Control

onready var _left_button = $Layout/LeftButton as Control
onready var _option_button = $Layout/OptionButton as Control
onready var _right_button = $Layout/RightButton as Control

var _option_array : Array = []
var _current_option_in_preview : int = 0

func _ready() -> void:
	_left_button.connect("clicked", self, "_on_left_button_pressed")
	_right_button.connect("clicked", self, "_on_right_button_pressed")

func set_option_array(var _array : Array) -> void:
	_option_array = _array
	
	_change_option()

func _change_option():
	if _option_array:
		_option_button.set_values(_option_array[_current_option_in_preview]["title"])

func _on_left_button_pressed() -> void:
	if _current_option_in_preview <= 0:
		_current_option_in_preview = _option_array.size() - 1
	else:
		_current_option_in_preview -= 1
	
	_change_option()

func _on_right_button_pressed() -> void:
	if _current_option_in_preview >= _option_array.size() - 1:
		_current_option_in_preview = 0
	else:
		_current_option_in_preview += 1
	
	_change_option()

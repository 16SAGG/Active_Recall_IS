extends MarginContainer

export var new_title : String = "Title"
export var new_number : int  = 10
export var min_number : int = 5
export var max_number : int = 30

onready var _title = $Layout/Title as Label
onready var _content_number = $Layout/Layout/Content/Number as Label

func _ready() -> void:
	_title.text = new_title
	_content_number.text = str(new_number)

func _on_LeftButton_button_down():
	var _current_number : int = int(_content_number.text)
	
	if _current_number - 1 >= min_number:
		_current_number -= 1
		_content_number.text = str(_current_number)

func _on_RightButton_button_down():
	var _current_number : int = int(_content_number.text)
	
	if _current_number + 1 <= max_number:
		_current_number += 1
		_content_number.text = str(_current_number)

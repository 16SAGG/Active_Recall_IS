extends MarginContainer

export var new_placeholder : String = "Title"

onready var _content = $Content/Content as LineEdit

func _ready() -> void:
	_content.placeholder_text = new_placeholder

extends MarginContainer

export var new_title : String = "Title"

onready var _title = $Layout/Title as Label

func _ready() -> void:
	_title.text = new_title

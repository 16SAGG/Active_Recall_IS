extends Control

export (String, 'COMPLETED', 'UNCOMPLETE', 'NEXT') var status = 'NEXT'
export (String, 'L', 'M', 'J', 'V', 'S', 'D') var char_day = 'L'

onready var _day_label = $Content/DayLabel as Label
onready var _style = $Content/Style as Control
onready var _style_completed = $Content/Style/Completed as Control
onready var _style_uncomplete = $Content/Style/Uncomplete as Control
onready var _style_next = $Content/Style/Next as Control

func _ready() -> void:
	set_day_status(status)
	_set_char_day(char_day)

func set_day_status(new_status : String) -> void:
	for _s in _style.get_children():
		_s.visible = false
	
	match new_status:
		'COMPLETED':
			_style_completed.visible = true
		'UNCOMPLETE':
			_style_uncomplete.visible = true
		'NEXT':
			_style_next.visible = true

func _set_char_day(char_d : String) -> void:
	_day_label.text = char_d

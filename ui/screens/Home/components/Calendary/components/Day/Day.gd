extends Control

const STYLE_NEXT = preload ("res://ui/screens/Home/components/Calendary/components/Day/DayStatus_styles/StyleNextDay/StyleNextDay.tscn")
const STYLE_UNCOMPLETE = preload ("res://ui/screens/Home/components/Calendary/components/Day/DayStatus_styles/StyleUncompleteDay/StyleUncompleteDay.tscn")
const STYLE_COMPLETED = preload("res://ui/screens/Home/components/Calendary/components/Day/DayStatus_styles/StyleCompletedDay/StyleCompletedDay.tscn")

enum style {NEXT, COMPLETED, UNCOMPLETE}
enum char_day {L, M, J, V, S, D}

export (style) var current_style = style.NEXT
export (char_day) var current_char_day = char_day.L

onready var _style = $Content/DayStatus/Style as Control
onready var _char_day = $Content/CharDay as Label

func _ready() -> void:
	_setting_style(current_style)
	_setting_char_day(current_char_day)

func _setting_style(style) -> void:
	var _new_style : Control
	match style:
		0:
			_new_style = STYLE_NEXT.instance()
		1:
			_new_style = STYLE_COMPLETED.instance()
		2: 
			_new_style = STYLE_UNCOMPLETE.instance()
	_style.add_child(_new_style)

func _setting_char_day(day) -> void:
	match day:
		0:
			_char_day.text = 'L'
		1:
			_char_day.text = 'M'
		2:
			_char_day.text = 'J'
		3:
			_char_day.text = 'V'
		4:
			_char_day.text = 'S'
		5:
			_char_day.text = 'D'

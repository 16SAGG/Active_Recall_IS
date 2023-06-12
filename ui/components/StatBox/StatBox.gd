extends Control

const H1_HEADLINE = preload("res://miscellaneous/fonts/dynamic_fonts/H1_headline.tres")
const H2_HEADLINE = preload("res://miscellaneous/fonts/dynamic_fonts/H2_headline.tres")
const H4_HEADLINE = preload("res://miscellaneous/fonts/dynamic_fonts/H4_headline.tres")

const BODY_0 = preload("res://miscellaneous/fonts/dynamic_fonts/body_0.tres")
const BODY_1 = preload("res://miscellaneous/fonts/dynamic_fonts/body_1.tres")

export (String, "H1", "H2", "H4") var type_title = "H4"
export (String, "B0", "B1") var type_body = "B1"
export (String, "Int", "Float") var type_number = "Int"
export var new_title : String = "Hi"

onready var _count = $MarginContainer/Layout/Count as Label
onready var _title = $MarginContainer/Layout/Title as Label

func _ready():
	_title.text = new_title
	
	match type_title:
		"H1":
			_count.add_font_override("font", H1_HEADLINE)
		"H2":
			_count.add_font_override("font", H2_HEADLINE)
		"H4":
			_count.add_font_override("font", H4_HEADLINE)
	
	match type_body:
		"B0":
			_title.add_font_override("font", BODY_0)
		"B1":
			_title.add_font_override("font", BODY_1)

func set_values(var _new_count : float) -> void:
	match type_number:
		"Float":
			_count.text = str(_new_count).pad_decimals(1)
		"Int":
			_count.text = str(int(_new_count))

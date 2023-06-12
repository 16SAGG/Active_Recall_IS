extends "res://ui/components/ButtonBase/ButtonBase.gd"

onready var _front_title = $Pivot/Front/MarginContainer/Title as Label
onready var _back_title = $Pivot/Back/MarginContainer/Title as Label

export var _new_front_title : String = "Borrar"
export var _new_back_title : String = "Borrar"

func _ready() -> void:
	_front_title.text = _new_front_title
	_back_title.text = _new_back_title

func restart() -> void:
	_front.visible = true
	_back.visible = false

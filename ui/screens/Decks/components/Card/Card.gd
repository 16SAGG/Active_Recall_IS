extends "res://ui/components/ButtonBase/ButtonBase.gd"

signal card_pressed(button)

onready var _question_label_back = $Pivot/Back/MarginContainer/Layout/Question as Label
onready var _answer_label_back = $Pivot/Back/MarginContainer/Layout/Answer as Label
onready var _question_label_front = $Pivot/Front/MarginContainer/Layout/Question as Label
onready var _answer_label_front = $Pivot/Front/MarginContainer/Layout/Answer as Label

var data : Dictionary

func _ready() -> void:
	_set_values(data["question"]["title"], data["answer"]["title"])

func _set_values(var _question_title : String, var _answer_title : String) -> void:
	_question_label_back.text = _question_title
	_answer_label_back.text = _answer_title
	_question_label_front.text = _question_title
	_answer_label_front.text = _answer_title

func _on_BackTrigger_pressed():
	emit_signal("card_pressed", self)

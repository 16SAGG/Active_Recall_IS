extends "res://ui/components/ButtonBase/ButtonBase.gd"

onready var _question_label = $Pivot/Front/MarginContainer/Content/Concept as Label
onready var _front_reviews = $Pivot/Front/MarginContainer/Content/Reviews as Label
onready var _front_hits = $Pivot/Front/MarginContainer/Content/Hits as Label
onready var _front_effectivity = $Pivot/Front/MarginContainer/Content/Effectivity as Label

onready var _answer_label = $Pivot/Back/MarginContainer/Content/Concept as Label
onready var _back_reviews = $Pivot/Back/MarginContainer/Content/Reviews as Label
onready var _back_hits = $Pivot/Back/MarginContainer/Content/Hits as Label
onready var _back_effectivity = $Pivot/Back/MarginContainer/Content/Effectivity as Label

var question : String = "Hello"
var answer : String = "Hola"
var reviews : float = 15.0
var hits : float = 13.0
var effectivity : float = 86.6666666667

func _ready() -> void:
# warning-ignore:narrowing_conversion
# warning-ignore:narrowing_conversion
	_set_values(question, answer, reviews, hits, effectivity)

func _set_values(var _question : String,  var _answer : String, var _reviews : int, var _hits : int, var _effectivity : float) -> void:
	_question_label.text = _text_supervisor(_question)
	_answer_label.text = _text_supervisor(_answer)
	
	_front_reviews.text = str(_reviews)
	_front_hits.text = str(_hits)
	_front_effectivity.text = str(_effectivity).pad_decimals(1)
	
	_back_reviews.text = str(_reviews)
	_back_hits.text = str(_hits)
	_back_effectivity.text = str(_effectivity).pad_decimals(1)

func _text_supervisor(var _text : String) -> String:
	var _text_limit : int = 35
	var _new_text : String = ""
	if _text.length() > _text_limit:
		for _t in _text:
			if _new_text.length() < _text_limit:
				_new_text += _t
			else:
				_new_text += "..."
				break
	else:
		_new_text = _text
	
	return _new_text

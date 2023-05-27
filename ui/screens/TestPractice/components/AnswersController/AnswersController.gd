extends VBoxContainer

signal correct_answer
signal wrong_answer

onready var move_player : AnimationPlayer = $MovePlayer
onready var _answers_array : Array = [
	$FirstAnswerRow/FirstAnswer as Control,
	$FirstAnswerRow/SecondAnswer as Control,
	$SecondAnswerRow/ThirdAnswer as Control,
	$SecondAnswerRow/FourthAnswer as Control,
]

func _ready() -> void:
	for _a in _answers_array:
		_a.connect("answer_selected", self, "_on_answer_pressed")

func start(var _correct_answer : String, _wrong_answers : Array) -> void:
	for _a in _answers_array:
		_answer_default(_a)
	_set_values(_correct_answer, _wrong_answers)

func _answer_default(var _answer : Control) -> void:
	_answer.disabled(false)
	_answer.front.visible = true
	_answer.back.visible = false
	_answer.side = "FRONT"

func _set_values(var _correct_answer : String, _wrong_answers : Array) -> void:
	_answers_array.shuffle()
	var _duplicates : int = 0
	
	for _a in range(0, _wrong_answers.size()):
		if _correct_answer == _wrong_answers[_a]:
			_duplicates += 1
			_wrong_answers[_a] += " " + str(_duplicates)
	
	_answers_array[0].set_values(_correct_answer, "CORRECT")
	_answers_array[1].set_values(_wrong_answers[0], "WRONG")
	_answers_array[2].set_values(_wrong_answers[1], "WRONG")
	_answers_array[3].set_values(_wrong_answers[2], "WRONG")

func _on_answer_pressed(var _answer : Control) -> void:
	for _a in _answers_array:
		_a.disabled(true)
	
	if _answer.is_correct:
		emit_signal("correct_answer")
	else:
		emit_signal("wrong_answer")
		for _a in _answers_array:
			if _a.is_correct:
				_a.front_action()

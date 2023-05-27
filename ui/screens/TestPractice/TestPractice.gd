extends "res://ui/screens/PracticeOptionBase.gd"

onready var _header = $MarginContainer/Layout/Header as Label
onready var _question_visor = $MarginContainer/Layout/CardPreview/QuestionVisor as Control
onready var _answers_controller = $MarginContainer/Layout/CardPreview/Inputs/AnswersController as VBoxContainer
onready var _continue_button =  $MarginContainer/Continue as Button

var _current_card : Dictionary

func _ready() -> void:
	_question_visor.connect("ready_for_base", self, "_on_ready_for_base")
	_answers_controller.connect("correct_answer", self, "_on_correct_answer")
	_answers_controller.connect("wrong_answer", self, "_on_wrong_answer")

func start() -> void:
	_continue_button.visible = false
	
	if _study_array:
		_study_lap()
	else:
		_hits = 0
		_congrats_suporter(true)

func _study_lap() -> void:
	_current_card = _study_array.pop_front()
	
	_header.change_text(USERDATA.current_deck_data["title"] + "(" + str(_hits) + " de " + str(_registered_array.size()) + ")")
	_question_visor.start(_current_card["question"], _current_card["answer"])
	
	var _wrong_answers : Array
	for _a in range(0,3):
		_wrong_answers.append(_generate_fake_answer(_registered_array))
	_answers_controller.start(_current_card["answer"]["title"], _wrong_answers)
	
	_question_visor.move_player.play("GO_DOWN")
	_answers_controller.move_player.play("IN")

func _generate_fake_answer(var _card_array : Array) -> String:
	var _fake_answer : Dictionary
	
	_fake_answer = _current_card
	var _pot : Array = _card_array.duplicate()
	while(_fake_answer["card_id"] == _current_card["card_id"]):
		_pot.shuffle()
		_fake_answer = _pot[0]
	
	var _fake_answer_str = _fake_answer["answer"]["title"]
	
	return _fake_answer_str

func _answer_behaviour(var _result : String) -> void:
	match _result:
		"CORRECT":
			_header.change_text("Respuesta correcta")
			_hits += 1
		"WRONG":
			_header.change_text("Respuesta incorrecta")
			_study_array.append(_current_card)
	
	_current_card = _submit_answer(_current_card, _result)
	_question_visor.show_answer(_result)

func _on_correct_answer() -> void:
	_answer_behaviour("CORRECT")

func _on_wrong_answer() -> void:
	_answer_behaviour("WRONG")

func _on_ready_for_base() -> void:
	_header.change_text("Clic para continuar")
	_question_visor.show_base(_current_card["question"]["title"], _current_card["space_btwn_sessions"])
	_continue_button.visible = true
	_answers_controller.move_player.play("OUT")

func _on_Continue_pressed():
	start()

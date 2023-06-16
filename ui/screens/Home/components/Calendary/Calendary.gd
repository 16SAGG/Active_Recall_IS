extends "res://ui/components/ButtonBase/ButtonBase.gd"

onready var _days_count = $Pivot/Front/MarginContainer/Content/DaysStreak/DaysCount as Label
onready var _message = $Pivot/Front/MarginContainer/Content/Message as Label
onready var _weekdays = $Pivot/Front/MarginContainer/Content/Weekdays as HBoxContainer

var _today_dict : Dictionary
var _user_history : Array

func _ready() -> void:
	print("Review the margins of the buttons DELETE THIS CODE IN CALENDARY")

func start() -> void: 
	_restart()
	
	USERDATA.set_user_history()
	_user_history = USERDATA.user_history
	_set_weekdays()
	_set_days_in_row()

func _restart() -> void: 
	for _w in _weekdays.get_children():
		_w.set_day_status('NEXT')

func _set_days_in_row() -> void:
	var _current_row : int = 0 
	var _last_history : int = CARDCULATIONS.today_date
	
	for _h in _user_history:
		if _h["date"] == _last_history:
			if _current_row < 1:
				_current_row = 1
			continue
		else:
			if _h["date"] == _last_history - CARDCULATIONS.UNIX_DAY:
				_current_row += 1
				
				_last_history = _h["date"]
			else:
				break
	
	_days_count.text = str(_current_row) + " "
	
	if _current_row == 0: 
		_message.text = "Buen momento para empezar."
	elif _current_row >= 1 and _current_row < 5:
		_message.text = "Sigue así!"
	elif _current_row >= 5 and _current_row < 20:
		_message.text = "Vas muy bien!"
	else:
		_message.text = "Eres excelente!"

func _set_weekdays() -> void:
	if not _today_dict:
		_today_dict = OS.get_datetime_from_unix_time(CARDCULATIONS.today_date)
	var _index_day : int = _today_dict["weekday"]
	
	while (_index_day >= 0):
		var _multipier :int = _today_dict["weekday"] - _index_day
		var _current_day : int = CARDCULATIONS.today_date - _multipier * CARDCULATIONS.UNIX_DAY
		var _has_history_in_day : bool = false
		
		for _d in _user_history:
			if _d["date"] == _current_day:
				_has_history_in_day = true
				break
		
		if _has_history_in_day:
			_weekdays.get_children()[_index_day].set_day_status('COMPLETED')
		else:
			_weekdays.get_children()[_index_day].set_day_status('UNCOMPLETE')
		
		_index_day -= 1

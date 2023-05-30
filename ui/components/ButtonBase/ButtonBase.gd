extends Control

signal normal_flip (button)
signal back_flip (button)
signal front_flip (button)

export (bool) var has_back = false
export (bool) var flip_timer_active = true
export (String, "FRONT", "BACK") var side = "FRONT"

onready var button_base_player = $ButtonBasePlayer as AnimationPlayer
onready var flip_timer_player = $FlipTimerPlayer as AnimationPlayer

onready var _pivot = $Pivot as Position2D

onready var _front = $Pivot/Front as Control
onready var _front_trigger = $Pivot/Front/FrontTrigger as Button

onready var _back = $Pivot/Back as Control
onready var _back_trigger = $Pivot/Back/BackTrigger as Button

onready var _button_recharge = $ButtonRecharge as Timer

func fit_size(var _new_size : Vector2) -> void:
	if _new_size:
		self.rect_size = _new_size
		self.rect_min_size  =_new_size
	
	_pivot.position = self.rect_size/2
	
	_front.rect_position = self.rect_size/-2
	_front.rect_size = self.rect_size
	
	_back.rect_position = self.rect_size/-2
	_back.rect_size = self.rect_size
	print(rect_size)

func disabled(var _value : bool) -> void:
	_front_trigger.disabled = _value
	_back_trigger.disabled = _value

func flip_action() -> void:
	button_base_player.play("FLIP")

func front_action() -> void:
	if flip_timer_active:
		flip_timer_player.play("FLIP_TIMER")
	button_base_player.play("FLIP_TO_BACK")

func back_action() -> void:
	if flip_timer_active:
		flip_timer_player.stop()
	button_base_player.play("FLIP_TO_FRONT") 

func _disable_button( var _input : bool) -> void:
	match _input:
		true:
			_front_trigger.disabled = true
			_back_trigger.disabled = true
			modulate = "7fffffff"
		false:
			_front_trigger.disabled = false
			_back_trigger.disabled = false
			modulate = "ffffff"
	

func _on_FrontTrigger_pressed() -> void:
	if not button_base_player.is_playing() and _button_recharge.is_stopped():
		match has_back:
			true:
				front_action()
			false:
				flip_action()

func _on_BackTrigger_pressed():
	if not button_base_player.is_playing() and _button_recharge.is_stopped():
		match has_back:
			true:
				back_action()
			false:
				flip_action()

func _on_ButtonBasePlayer_animation_finished(anim_name) -> void:
	_button_recharge.start()
	match anim_name:
		"FLIP":
			emit_signal("normal_flip", self)
		"FLIP_TO_BACK":
			emit_signal("back_flip", self)
		"FLIP_TO_FRONT":
			emit_signal("front_flip", self)

func _on_FlipTimerPlayer_animation_finished(anim_name) -> void:
	if anim_name == "FLIP_TIMER":
		back_action()

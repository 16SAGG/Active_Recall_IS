extends Control

signal click_outside

export var active : bool = true

func _input(event) -> void:
	if Input.is_action_just_pressed("ui_click") and active:
		var _mouse_position : Vector2 = get_local_mouse_position()
		var _outside_x : bool = false
		var _outside_y : bool = false
		if _mouse_position.x < 0 or _mouse_position.x > rect_min_size.x:
			_outside_x = true
		if  _mouse_position.y < 0 or _mouse_position.y > rect_min_size.y:
			_outside_y = true
		
		if _outside_x or _outside_y:
			emit_signal("click_outside")
	
	var _unused_vars = [event] #To avoid warnings

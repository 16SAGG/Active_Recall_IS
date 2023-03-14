extends Position2D

const DICT_POSITION = {
	'HOME': Vector2(0,216),
	'DECK': Vector2(0,280),
	'PRACTICE': Vector2(0,344),
	'STATS': Vector2(0,408),
	'SETTINGS': Vector2(0,472),
}

const TRANSITION_DURATION : float = 0.4

onready var _tween = $Tween as Tween

var anim_ready : bool = true

func go_to(destiny : String) -> void:
	print('The Selector Rect will be able to move to ' + destiny)
	anim_ready = false
	_tween.interpolate_property(
		self, 
		"position",
		position,
		DICT_POSITION[destiny],
		TRANSITION_DURATION,
		Tween.TRANS_CUBIC, #BACK; CIRC; CUBIC; QUAD;
		Tween.EASE_IN_OUT
	)
	_tween.start()

func _on_Tween_tween_completed(object, key):
	anim_ready = true

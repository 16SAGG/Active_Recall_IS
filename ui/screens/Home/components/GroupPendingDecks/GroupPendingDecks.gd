extends Control

const MIN_CLIP_SIZE = 368

onready var content = $Layout/MarginContainer/ScrollContainer/Content as VBoxContainer

onready var _scroll = $Layout/MarginContainer/ScrollContainer as ScrollContainer
onready var _PD_scroller_up = $PDScrollerUp as Control
onready var _PD_scroller_down = $PDScrollerDown as Control

func _ready() -> void:
	pass

func start() -> void:
	if content.rect_size.y >= MIN_CLIP_SIZE:
		_PD_scroller_down.anim_player.play("SHOW")
	_scroll.scroll_vertical = 0

# warning-ignore:unused_argument
func _process(delta) -> void:
	if _PD_scroller_up.trigger.pressed:
		if not _PD_scroller_down.anim_player.is_playing() and not _PD_scroller_down.visible:
			_PD_scroller_down.anim_player.play("SHOW")
		
		_scroll.scroll_vertical -= 5
		
		if _scroll.scroll_vertical == 0:
			_PD_scroller_up.anim_player.play("HIDE")
		
	if _PD_scroller_down.trigger.pressed:
		var _last_scroll_v : int = _scroll.scroll_vertical
		
		if not _PD_scroller_up.anim_player.is_playing() and not _PD_scroller_up.visible:
			_PD_scroller_up.anim_player.play("SHOW")
		
		_scroll.scroll_vertical += 5
		
		if _scroll.scroll_vertical == _last_scroll_v:
			if not _PD_scroller_down.anim_player.is_playing() and _PD_scroller_down.visible:
				_PD_scroller_down.anim_player.play("HIDE")

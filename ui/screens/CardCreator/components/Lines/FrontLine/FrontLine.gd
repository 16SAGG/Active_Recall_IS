extends Control

signal permission_to_enter(permission, origin)

onready var _animation_player = $AnimationPlayer as AnimationPlayer
onready var _front_edit = $MarginContainer/Content/FrontEdit as LineEdit
onready var _error_label = $MarginContainer/Content/Head/Error as Label
onready var _image_button = $MarginContainer/Content/Image/IMGButton as Button

var _image_showed : bool = false


func _ready() -> void:
# warning-ignore:return_value_discarded
	_image_button.connect("pressed", self, "_on_IMGButton_pressed")

func start(var _status : String) -> void:
	match _status:
		"CREATOR":
			_error_label.visible = true
			_error_label.text = "Vacío"
			emit_signal("permission_to_enter", false, self)
		"EDITOR":
			_error_label.visible = false
			emit_signal("permission_to_enter", true, self)

func show_image () -> void :
	if not _image_showed:
		_image_showed = true
		_animation_player.play("SHOW_IMAGE")

func hide_image () -> void :
	if _image_showed:
		_image_showed = false
		_animation_player.play("HIDE_IMAGE")

func _on_IMGButton_pressed () -> void:
	hide_image() 

# warning-ignore:unused_argument
func _on_FrontEdit_text_changed(new_text):
	_error_label.visible = false
	emit_signal("permission_to_enter", true, self)
	if TEXTFORMAT.remove_unnecessary_space(_front_edit.text) == "":
		_error_label.visible = true
		_error_label.text = "Vacío"
		emit_signal("permission_to_enter", false, self)
	else:
		for _d in USERDATA.current_deck_data["cards"]:
			if TEXTFORMAT.remove_unnecessary_space(_front_edit.text).to_upper() == _d["question"]["title"].to_upper():
				_error_label.visible = true
				_error_label.text = "Duplicado"
				emit_signal("permission_to_enter", false, self)
				break

extends Control

signal back_line_hide()
signal permission_to_enter(permission, origin)

onready var _animation_player = $AnimationPlayer as AnimationPlayer
onready var _back_edit = $MarginContainer/Content/BackEdit as LineEdit
onready var _error_label = $MarginContainer/Content/Head/Error as Label
onready var _image = $MarginContainer/Content/HBoxContainer/Image as Control
onready var _image_button = $MarginContainer/Content/HBoxContainer/Image/IMGButton as Button

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

func change_image (var _img_dir : String) -> void:
	_image.image_dir = _img_dir

func hide_image () -> void :
	emit_signal("back_line_hide")
	if _image_showed:
		_image_showed = false
		_animation_player.play("HIDE_IMAGE")

func _on_IMGButton_pressed () -> void:
	hide_image() 

# warning-ignore:unused_argument
func _on_BackEdit_text_changed(new_text):
	_error_label.visible = false
	emit_signal("permission_to_enter", true, self)
	if TEXTFORMAT.remove_unnecessary_space(_back_edit.text) == "":
		_error_label.visible = true
		_error_label.text = "Vacío"
		emit_signal("permission_to_enter", false, self)

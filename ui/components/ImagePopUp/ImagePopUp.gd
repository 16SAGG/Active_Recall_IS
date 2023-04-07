extends Control

const IMAGE = preload("res://ui/components/Image/Image.tscn")

export (bool) var showed = false

onready var _new_image = $Pivot/MarginContainer/Content/NewImage as Control

var _img_array : Array = []

func _ready() -> void:
	_new_image.connect("normal_flip", self, "_on_new_image_pressed")
	
	start()

func start() -> void:
	_img_array = _load_data()

func _load_data() -> Array:
	var _result_array : Array
	for _i in USERDATA.images_data:
		_result_array.append(_create_image(_i.image_id, _i.format, _i.data))
	
	return _result_array

func _create_image(_id : int, _format : int, _data : String) -> Control:
	var _image : Control = IMAGE.instance()
	
	_image.id = _id
	_image.format = _format
	_image.data = _data
	
	return _image

func _on_new_image_pressed(_button: Control) -> void:
	pass

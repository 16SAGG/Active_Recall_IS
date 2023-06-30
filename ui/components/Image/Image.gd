extends Control

const IMG_PLACEHOLDER = "res://miscellaneous/image/IMG_PLACEHOLDER.png"

onready var _texture_rect = $MarginContainer/TextureRect as TextureRect
onready var _img_button = $IMGButton as Button

var id : int
var format : int
var data : String
var image_dir : String = "" 

func change_image(var _new_image_dir : String) -> String:
	var _texture : ImageTexture = ImageTexture.new()
	var _image : Image = Image.new()
	var _file : File = File.new()
	
	var _action : String
	
	if _file.file_exists(_new_image_dir):
		_image.load(_new_image_dir)
		image_dir = _new_image_dir
		_action = "SUCCESS"
	else:
		_image.load(IMG_PLACEHOLDER)
		image_dir = ""
		_action = "ERROR"
	
	_texture.create_from_image(_image)
	_texture_rect.texture = _texture
	
	return _action

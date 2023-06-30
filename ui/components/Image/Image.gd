extends Control

onready var _texture_rect = $MarginContainer/TextureRect as TextureRect

var id : int
var format : int
var data : String
var image_dir : String setget _change_image

func _change_image(var _new_image_dir : String) -> void:
	var _texture = ImageTexture.new()
	var _image = Image.new()
	_image.load(_new_image_dir)
	_texture.create_from_image(_image)
	
	image_dir = _new_image_dir
	
	_texture_rect.texture = _texture

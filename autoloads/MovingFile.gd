extends Node

const IMAGE_PATH : String = "/ARP/media/image/"

onready var system_user : String = OS.get_environment("USERNAME")

func move_directory(var _original_path : String):
	var _abs_image_dir : String = "C:/Users/" + system_user + IMAGE_PATH
	
	var _dir : Directory = Directory.new()
	var _file = File.new()
	
	var _file_name : String = "image_"
	var _index : int = 0 
	
	if _dir.dir_exists(_abs_image_dir) == false:
		_dir.make_dir_recursive(_abs_image_dir)
	
	while _file.file_exists(_abs_image_dir + _file_name + str(_index) + ".png"):
		_index += 1
	
	var _file_dir : String = _abs_image_dir + _file_name + str(_index) + ".png"
	
	_file.open(_file_dir, File.WRITE)
	_file.close()
	
	_dir.copy(_original_path, _file_dir)
	
	return _file_dir

func delete_file(var _path : String) -> void:
	var _dir : Directory = Directory.new()
	
	_dir.remove(_path)

func change_file_name(var _old_name : String, var _new_name) -> void:
	var _dir : Directory = Directory.new()
	
	_dir.rename(_old_name, _new_name)

extends Node

func remove_unnecessary_space(var _text : String) -> String:
	_text = _text.dedent()
	
	if _text.length() - 1 >= 0:
		while (_text[_text.length() - 1] == " "):
			_text.erase(_text.find_last(" "), 1)
	
	return _text

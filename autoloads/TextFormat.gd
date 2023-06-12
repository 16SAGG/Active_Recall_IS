extends Node

func _ready():
	pass
#	print(email_format("samuelagg16@gmail.com"))
#	print(email_format("/\abcdefghijklmnopqrstuvwxyz.@0123456789"))
#	print(email_format("samuelag g16@gmail.com"))
#	print(email_format("@gmail.com"))
#	print(email_format("gmail.com"))
#	print(email_format("samuel@@gmail.com"))
#	print(email_format(".com@.com"))
#	print(email_format(".com@"))
#	print(email_format("samuel@.com"))
#	print(email_format("samuel@gmail"))
#	print(email_format(".com@samuel"))
#	print(email_format("samuelagg16@gmail.com123"))
	
#	print(password_format("s#amu3425"))
#	print(password_format("3425samu#"))
#	print(password_format("s'amu3425"))
#	print(password_format("samu3425"))
#	print(password_format("####3425"))
#	print(password_format("samu####"))

func remove_unnecessary_space(var _text : String) -> String:
	_text = _text.dedent()
	
	if _text.length() - 1 >= 0:
		while (_text[_text.length() - 1] == " "):
			_text.erase(_text.find_last(" "), 1)
	
	return _text

func email_format(var _text : String) -> String:
	_text = remove_unnecessary_space(_text).to_lower()
	var _duplicated_email : bool = false
	var _valid_chars : bool = true
	var _valid_email : bool = true
	
	for _u in USERDATA.users_data:
		if _u["email"] == _text:
			_duplicated_email = true
	
	for _t in _text:
		if is_a_letter(_t) or "." == _t or "@" == _t or is_a_number(_t):
			continue
		else:
			_valid_chars = false
	
	if _duplicated_email:
		print(_text + " ERROR: Email Duplicado")
		_valid_email = false
	elif not _valid_chars:
		print(_text + " ERROR: Simbolo invalido")
		_valid_email = false
	elif _text.countn("@") != 1: 
		print(_text + " ERROR: Mas de un @ o ningún @")
		_valid_email = false
	elif _text.findn("@") == 0 or _text.rfind("@") == _text.length() - 1:
		print(_text + " ERROR: Posición del arroba")
		_valid_email = false
	elif _text.countn(".com") != 1:
		print(_text + " ERROR: Mas de un .com o ningún .com")
		_valid_email = false
	elif _text.find(".com") != _text.length() - 4:
		print(_text + " ERROR: Posición del .com")
		_valid_email = false
	elif _text.find(".com") == _text.find("@") + 1:
		print(_text + " ERROR: Sin servidor")
		_valid_email = false
	
	if not _valid_email:
		return "invalid_email"
	
	return _text

func password_format(var _text : String, var _min_limit : int) -> String:
	_text = remove_unnecessary_space(_text).to_lower() #Don't care the caps
	var _has_letters : bool = false
	var _has_numbers : bool = false
	var _has_symbols : bool = false
	
	if _text.length() >= _min_limit:
		for _t in _text:
			if is_a_letter(_t) and not _has_letters:
				_has_letters = true
			if is_a_number(_t) and not _has_numbers:
				_has_numbers = true
			if is_a_symbol(_t) and not _has_symbols:
				_has_symbols = true
	
	if _has_letters and _has_numbers and _has_symbols:
		return _text
	
	return "invalid_password"

func is_a_letter(var _char : String) -> bool:
	if "a" == _char or "b" == _char or "c" == _char or "d" == _char  or "e" == _char or "f" == _char or "g" == _char or "h" == _char or "i" == _char or "j" == _char or "k" == _char or "l" == _char or "m" == _char or "n" == _char or "o" == _char or "p" == _char or "q" == _char or "r" == _char or "s" == _char or "t" == _char or "u" == _char or "v" == _char or "w" == _char or "x" == _char or "y" == _char or "z" == _char:
		return true
	
	return false

func is_a_number(var _char : String) -> bool:
	if "0" == _char or "1" == _char or "2" == _char or "3" == _char or "4" == _char or "5" == _char or "6" == _char or "7" == _char or "8" == _char or "9" == _char:
		return true
	
	return false

func is_a_symbol(var _char : String) -> bool:
	if "@" == _char or "#" == _char or "$" == _char or "%" == _char or "&" == _char or "+" == _char or "-" == _char or "*" == _char :
		return true
	
	return false

extends Node2D

const INTER_KEYBOARD_BUTTON_SPACING = 10
const INTER_KEYBOARD_ROW_SPACING = 15
const MIN_KEYBOARD_BUTTON_WIDTH = 135
const MIN_KEYBOARD_BUTTON_HEIGHT = 150
const NUMBER_OF_KEYBOARD_ROWS = 4

const INTER_LETTER_GUESS_SPACER = 10
const INTER_WORD_GUESS_SPACER = 40
const INTER_LINE_GUESS_SPACER = 20
var initialized = false
var strikes = 0

func clean(t):
	return t.strip_edges().to_lower()

const guess = "can i get\nyour number ?"
var guessed = []
const valid_alphabet = "abcdefghijklmnopqrstuvwxyz"

func get_all_to_guess():
	var u = []
	for l in guess:
		if valid_alphabet.contains(l) and u.find(l) < 0:
			u.append(l)

	return u.size()



func get_remaining():
	return get_all_to_guess() - guessed.size()



func get_spacer(x=0, y=0):
	var s = AspectRatioContainer.new()			
	s.set_custom_minimum_size(Vector2(x, y))
	return s
#
# Guess place
#

func gen_word(word : String):
	var word_c = HBoxContainer.new()
	for li in len(word):
		var l = word.substr(li, 1)
		var l_label = Label.new()
		l_label.text = "_"
		if !valid_alphabet.contains(l.to_lower()):
			l_label.text = l.to_upper()
		else:
#			l_label.text = l
			l_label.add_to_group(get_guess_label_group(l))
		word_c.add_child(l_label)
		if li != len(word)-1:
			var s = AspectRatioContainer.new()
			s.set_custom_minimum_size(Vector2(INTER_LETTER_GUESS_SPACER, 0))
			word_c.add_child(s)
		
	
	return word_c

func get_guess_label_group(t : String):
	return "label-" + clean(t).to_lower()
func generate_guess_place():
	var guess_upper = guess.strip_edges().to_upper()
	var rows = VBoxContainer.new()
	var rows_s = guess.split("\n")
	
	for ri in rows_s.size():
		var row_c = HBoxContainer.new()
		var row = rows_s[ri]
		var words_s =  row.split(" ")
		for wi in words_s.size():
			var word = words_s[wi]
			var word_c = gen_word(word)
			row_c.add_child(word_c)
			if wi != words_s.size() -1:
				row_c.add_child(get_spacer(INTER_WORD_GUESS_SPACER))
		var c_row_c = CenterContainer.new()
		c_row_c.add_child(row_c)
		rows.add_child(c_row_c)
			
			

	var x = CenterContainer.new()
	x.add_child(rows)
	
	return x

	

#
# Keyboard
#
func get_button_group(t : String):
	return "button-" + clean(t).to_lower()
func generate_button(letter="a"):
	var b = Button.new()
	b.set_custom_minimum_size(Vector2(MIN_KEYBOARD_BUTTON_WIDTH, MIN_KEYBOARD_BUTTON_HEIGHT))
	b.add_to_group( get_button_group(letter) )
	b.pressed.connect(func() : self.handle_letter(letter))
#	 = Vector2(0, 40)
	b.text = letter.to_upper()
	
	
	
	return b

func generate_keyboard_row(arr=[]):
	var buttons = []
	var row = HBoxContainer.new()
	for l in arr:
		row.add_child(generate_button(l))
		if l != arr[len(arr)-1]:
			var spacer = AspectRatioContainer.new()
			spacer.set_custom_minimum_size(Vector2(INTER_KEYBOARD_BUTTON_SPACING, 0))
			row.add_child(spacer)

	var c = CenterContainer.new()
	c.add_child(row)
	return c
func generate_keyboard(rows = NUMBER_OF_KEYBOARD_ROWS):
	var alphabet = valid_alphabet.split("")
	var total = len(alphabet)
	var per_row = 	ceil(float(total)/ rows)
	
	var keyboard_v = VBoxContainer.new()
	for i in range(rows):
		var new_arr = alphabet.slice(int(per_row *i), int(per_row*(i+1)))
		keyboard_v.add_child(generate_keyboard_row(new_arr))
		if i != rows - 1:
			var spacer = AspectRatioContainer.new()
			spacer.set_custom_minimum_size(Vector2(0,INTER_KEYBOARD_ROW_SPACING))
			keyboard_v.add_child(spacer)
	var c = CenterContainer.new()
	c.add_child(keyboard_v)
	$CenterContainer/VBoxContainer/KeyboardContainer.add_child(c)
	
	
	
	
	var Keyboard =  Container.new()
	
	
	
	return Keyboard


func update_hangman():
	if !initialized:
		return
	if strikes ==  0:
		return
	var parts =  $CenterContainer/VBoxContainer/Container.get_child(0).get_child(1).get_children()
	
	if strikes > parts.size():
		return
	var i = strikes -1
	parts[i].visible = true
	

func handle_letter(letter:String):
	var cleaned = clean(letter)
	
	for i in get_tree().get_nodes_in_group(get_guess_label_group(letter)):
		i.text = cleaned.to_upper()
	
	for i in get_tree().get_nodes_in_group(get_button_group(letter)):
		i.disabled = true
		var col = Color(0,1,0)
		
		if !guess.strip_escapes().to_lower().contains(cleaned) :
			col = Color(1,0,0)
			if initialized:
				strikes += 1
		else:
			guessed.append(cleaned)

		i.set("theme_override_colors/font_disabled_color", col)
	print(get_remaining())
	if get_remaining() ==0:
		get_tree().change_scene_to_file("res://scenes/AfterWon/AfterWon.tscn")
	update_hangman()
#	if len(guessed) == len(groups):
#		get_tree().change_scene_to_file("res://justWon.tscn")



func _ready():
	var KeyboardContainer = $CenterContainer/VBoxContainer/KeyboardContainer
	KeyboardContainer.add_child(generate_keyboard())
	var x = preload("res://components/Hangman/Machnaka/person.tscn").instantiate()
	for i in x.get_children()[1].get_children():
		i.visible = false
	$CenterContainer/VBoxContainer/Container.add_child(x)
	$CenterContainer/VBoxContainer/CenterContainer/PhraseToGuessContainer.add_child(	generate_guess_place())
	var initial_guesses = "bculw"
#	initial_guesses = "canigetyounumbe"
	for l in initial_guesses:
		handle_letter(l)
	initialized = true



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):

	pass

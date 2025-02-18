extends Node2D


const INTER_LETTER_GUESS_SPACER = 10
const INTER_WORD_GUESS_SPACER = 40
const INTER_LINE_GUESS_SPACER = 20

const RADIUS = 250
var rng = RandomNumberGenerator.new()

var c = 0

func clean(t):
	return t.strip_edges().to_lower()

const guess = "can i get\nyour number ?"
const valid_alphabet = "abcdefghijklmnopqrstuvwxyz"
var guessed = []

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

		l_label.text = l.to_upper()

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


# Called when the node enters the scene tree for the first time.
func _ready():
#	$CenterContainer/VBoxContainer/ANSWER_CONTAINER/YES_BUTTON
	$CenterContainer/VBoxContainer/CenterContainer/GuessedPhrase.add_child(generate_guess_place())
	var yes_g_pos = $CenterContainer/VBoxContainer/ANSWER_CONTAINER/CenterContainer/YES_BUTTON.get_global_rect().position
	$CenterContainer/VBoxContainer/ANSWER_CONTAINER/Container/NO_BUTTON.set_global_position(Vector2(0, yes_g_pos.y ))
#	var ACP = $CenterContainer/VBoxContainer/ANSWER_CONTAINER.get_begin()
	
#	print($CenterContainer/VBoxContainer/ANSWER_CONTAINER.())
#	Rect2()
#	print(Vector2( (ACP.size.x )/2 ,  (ACP.end.y - ACP.position.y)/2))
#	$CenterContainer/VBoxContainer/ANSWER_CONTAINER/Container/YES_BUTTON.set_position(Vector2( (ACP.end.x - ACP.position.x)/2 ,  (ACP.end.y - ACP.position.y)/2))



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_yes_button_pressed():

	get_tree().change_scene_to_file("res://scenes/SaveNumber/SaveNumber.tscn")

#	$CenterContainer/VBoxContainer/ANSWER_CONTAINER/CenterContainer/YES_BUTTON.hide()
	pass # Replace with function body.

	
func get_new_angle(old_angle : float):
	var new_angle = old_angle +  rng.randf_range((PI/4) + 0.2, (7*PI / 4) -.02)
	
	
	return new_angle
	

func _on_no_button_pressed():
	$CenterContainer/VBoxContainer/CenterContainer2/Label2.visible = true
	var yes_g_pos = $CenterContainer/VBoxContainer/ANSWER_CONTAINER/CenterContainer/YES_BUTTON.get_global_rect().position
	var c_g_pos = $CenterContainer/VBoxContainer/ANSWER_CONTAINER.get_global_rect()
	var no_g_pos = $CenterContainer/VBoxContainer/ANSWER_CONTAINER/Container/NO_BUTTON.get_global_rect().position
	var current_angle  =  Vector2(no_g_pos.x - yes_g_pos.x, no_g_pos.y- yes_g_pos.y).angle()
	var angle =    get_new_angle(current_angle)
	var v = Vector2(RADIUS, 0).rotated(angle)
	var new_pos = yes_g_pos + v
	
	$CenterContainer/VBoxContainer/ANSWER_CONTAINER/Container/NO_BUTTON.set_global_position(yes_g_pos + v)

	
	pass # Replace with function body.

extends Node2D

const  letters = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J","K", "L" , "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]


#const guess = "Can I Get your Number?"
#var words = guess.split(" ")



# Called when the node enters the scene tree for the first time.
const groups = ["g", "t", "c", "o", "m", "i", "b", "u", "y", "r", "a", "n", "e"]

var guessed = []


func generate_keyboard(rows = 3):
	pass

func generate_phrase_to_guess():
	pass

func _ready():
#	print(letters)
#	Button.new()
	
#		letterButton.disabled = true
	
	for g in groups	:
		for n in get_tree().get_nodes_in_group(g):
			n.text = "   "
	
	var buttons = []
	var buttonContainer = HBoxContainer.new()
	
	for l in letters:
		var letterButton = Button.new()
		letterButton.text = l
		
		
		letterButton.add_to_group("button-" + l.strip_edges().to_lower() )
		letterButton.pressed.connect(func() : self.handle_letter(l))

		buttonContainer.add_child(letterButton)
		buttonContainer.add_spacer(true)
		
		
#		get_tree().get_first_node_in_group(".").add_child()
#		print(l)
	buttonContainer.position.x = 0
	buttonContainer.position.y = 200
		
	get_node(".").add_child(buttonContainer)

	pass # Replace with function body.

func handle_letter(letter:String):
	var cleaned = letter.strip_edges().to_lower()
	
	for i in get_tree().get_nodes_in_group(cleaned):
		i.text = cleaned.to_upper()
	
	for i in get_tree().get_nodes_in_group("button-" + cleaned):
		i.disabled = true
		var col = Color(0,1,0)
		if groups.find(cleaned) < 0 :
			col = Color(1,0,0)
#			i.text = "X"
		else:
			guessed.append(cleaned)

		i.set("theme_override_colors/font_disabled_color", col)
		
	if len(guessed) == len(groups):
		get_tree().change_scene_to_file("res://justWon.tscn")
		print("Won")
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

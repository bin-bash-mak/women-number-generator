extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():

	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	var v = str($CenterContainer/VBoxContainer/CenterContainer/TextEdit.text).to_lower().strip_edges().strip_escapes()
	
#	print(v)
	if len(v) > 3 :
		OS.shell_open("tel:"+v)
	pass # Replace with function body.

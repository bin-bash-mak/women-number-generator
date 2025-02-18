extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_2_pressed():
	$CenterContainer/VBoxContainer/CenterContainer2/HBoxContainer/Label2.text = "Wrong Answer,\n Please try again"



func _on_button_pressed():
	get_tree().change_scene_to_file("res://scenes/game/game.tscn")
	pass # Replace with function body.

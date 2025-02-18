extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$Label.hide()
	$No2.hide()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_no_1_pressed():
	$No1.hide()
	$No2.show()
	$Label.show()
	pass # Replace with function body.


func _on_no_2_pressed():
	$No1.show()
	$No2.hide()
	$Label.show()
	pass # Replace with function body.


func _on_button_3_pressed():
	get_tree().change_scene_to_file("res://enterNumber.tscn")
	pass # Replace with function body.

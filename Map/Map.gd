extends Node2D


func _ready():
	pass

func _input(event):
	if Input.is_action_just_pressed("map"):
		visible = !visible

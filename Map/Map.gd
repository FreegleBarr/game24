extends Node2D

export var toggleabble := true

func _input(event):
	if toggleabble and Input.is_action_just_pressed("map"):
		visible = !visible

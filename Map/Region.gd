extends Area2D

export(PackedScene) var destination_scene


func _ready():
	connect("input_event", self, "_on_input_event")
	connect("mouse_entered", self, "_on_mouse_entered")
	connect("mouse_exited", self, "_on_mouse_exited")
	
	
	pass

func on_click():
	print("Clicked on ", name)
	if Overworld.village:
		Overworld.village.call_deferred("emit_signal","change_scene", destination_scene)


func _on_mouse_entered():
	print("Mouse entered ", name)


func _on_mouse_exited():
	print("Mouse exited ", name)


func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.is_pressed(): 
			on_click()

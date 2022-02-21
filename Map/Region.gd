extends Area2D

export(PackedScene) var destination_scene

onready var sprite = $Sprite

const pink = Color("#bf247b")
const cream = Color("#feffe5")

func _ready():
	if not $CollisionPolygon2D.disabled:
		connect("input_event", self, "_on_input_event")
		connect("mouse_entered", self, "_on_mouse_entered")
		connect("mouse_exited", self, "_on_mouse_exited")
	
		sprite.modulate = cream
		pass

func on_click():
	print("Clicked on ", name)
	if Overworld.village:
		Overworld.village.call_deferred("emit_signal","change_scene", destination_scene)


func _on_mouse_entered():
	print("Mouse entered ", name)
	sprite.modulate = pink
	Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)

func _on_mouse_exited():
	print("Mouse exited ", name)
	sprite.modulate = cream
	Input.set_default_cursor_shape(Input.CURSOR_ARROW)

func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.is_pressed(): 
			on_click()

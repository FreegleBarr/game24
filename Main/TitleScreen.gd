extends CanvasLayer

signal change_scene(target)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"):
		emit_signal("change_scene", "intro")

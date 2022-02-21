extends Node2D

export var toggleabble := true

func _input(event):
	if toggleabble and Input.is_action_just_pressed("map"):
		visible = !visible


func _on_Brain_mouse_entered() -> void:
	var tween = $brain/Tween
	tween.stop_all()
	tween.interpolate_property($brain, 'modulate',
		$brain.modulate, Color(1,38.0/255,167.0/255, 1), 0.2, Tween.TRANS_SINE, Tween.EASE_OUT)
	tween.start()

func _on_Brain_mouse_exited() -> void:
	var tween = $brain/Tween
	tween.stop_all()	
	tween.interpolate_property($brain, 'modulate',
	Color(1,38.0/255,167.0/255, 1), Color(1,130.0/255, 160.0/255, 1), 0.2, Tween.TRANS_CIRC, Tween.EASE_IN_OUT)
	tween.start()

extends Area2D

var selected := false setget set_selected


func _input(event):
	if not selected: return
	if Input.is_action_just_pressed("interact"):
		print("Hello! My name is ", name)

func set_selected(b:bool):
	selected = b
	if b:
		$KeyPrompt.play()
		$KeyPrompt.show()
	else:
		$KeyPrompt.hide()
		$KeyPrompt.stop()

func select():
	set_selected(true)
#	modulate = Color.red


func deselect():
	set_selected(false)
#	modulate = Color.white


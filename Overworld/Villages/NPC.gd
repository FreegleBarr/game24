extends Area2D

var selected := false setget set_selected

var interacting := false setget set_interacting

func _ready():
	set_selected(false)
	set_interacting(false)


func _input(event):
	if not selected: return
	if Input.is_action_just_pressed("interact"):
		set_interacting(not interacting)
		owner.emit_signal("npc_interaction", interacting)
		print("Hello! My name is ", name)

func set_interacting(b:bool):
	interacting = b
	$Label.visible = b

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


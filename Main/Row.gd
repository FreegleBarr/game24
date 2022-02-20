extends CenterContainer

signal done

var controller: Node2D = null

func start():
	assert(controller)
	for child in get_children():
		child.controller = controller
		child.start()
		yield(controller, "procceed")
	emit_signal("done")

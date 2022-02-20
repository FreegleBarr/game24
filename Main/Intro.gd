extends CanvasLayer

var current: ScreenFragment

func _ready() -> void:
	call_deferred("run")

func run():
	for i in range(get_child_count()):
		current = get_children()[i]
		current.start()
		yield(current, "ended")

extends TextureProgress

onready var timer := $Timer

func start(time):
	time += 4
	timer.wait_time = time
	max_value = time
	value = time
	timer.start()

func _process(_delta: float) -> void:
	if not timer.is_stopped():
		value = timer.time_left

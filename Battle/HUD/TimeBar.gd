extends TextureProgress

onready var timer := $Timer

func start(time):
	print(time)
	timer.wait_time = time
	max_value = time
	value = time
	timer.start()

func _process(delta: float) -> void:
	value = timer.time_left

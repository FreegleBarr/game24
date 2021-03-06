extends BaseAttack

signal spawn_bullet(type, pos, dir)

export(String) var projtype = 'virus'

onready var timer = $Timer

func start(args: Array) -> void:
	var repeats := int(args[0])
	var wait_time := float(args[1])
	
	var direction: Vector2 = -$Pivot/SpawnPoint.global_position
	var position: Vector2 = $Pivot/SpawnPoint.global_position
	emit_signal("spawn_bullet", projtype, position, direction)
	for _i in range(repeats-1):
		timer.wait_time = wait_time
		timer.start()
		yield(timer, "timeout")
		position = $Pivot/SpawnPoint.global_position
		direction = -position
		emit_signal("spawn_bullet", "virus", position, direction)
	
	emit_signal("attack_done")

func time(args: Array) -> float:
	var repeats := args[0] as int
	var wait_time := args[1] as float
	return (repeats-1)*wait_time

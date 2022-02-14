extends BaseAttack

signal spawn_bullet(pos, dir)

onready var spawn_position: Position2D = $SpawnPosition
onready var timer: Timer = $Timer

func start(_args: Array) -> void:
	var initial_direction = Vector2.RIGHT.rotated(randf()*TAU)
	for i in range(8):
		var direction = initial_direction.rotated(i*PI/4)
		emit_signal('spawn_bullet', spawn_position.position, direction)
		timer.start()
		yield(timer, "timeout")
	emit_signal('attack_done')

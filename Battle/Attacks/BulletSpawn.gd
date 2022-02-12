extends BaseAttack

signal spawn_bullet(type, pos, dir)

onready var spawn_position: Position2D = $SpawnPosition


func start(args: Array) -> void:
	var direction: Vector2 = Vector2.RIGHT.rotated(randf()*TAU)
	emit_signal('spawn_bullet', 'virus', spawn_position.position, direction)
	emit_signal('attack_done')

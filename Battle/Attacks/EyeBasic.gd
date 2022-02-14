extends BaseAttack

signal spawn_bullet(pos, dir)


onready var spawn = $SpawnPosition


func start(_args: Array) -> void:
	var direction: Vector2 = -spawn.position.normalized()
	emit_signal('spawn_bullet', "virus", spawn.position, direction)
	emit_signal('attack_done')

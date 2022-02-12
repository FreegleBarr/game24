extends BaseAttack

signal spawn_bullet(pos, dir)

var Bullet = preload("res://Battle/Projectiles/Bullet.tscn")

onready var spawn = $SpawnPosition


func _on_Timer_timeout() -> void:
	var direction = Vector2.RIGHT.rotated(randf()*TAU)
	emit_signal('spawn_bullet', spawn.position, direction)

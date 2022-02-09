extends Position2D

signal spawn_bullet(pos, dir)

var Bullet = preload("res://Battle/Bullet.tscn")



func _on_Timer_timeout() -> void:
	var direction = Vector2.RIGHT.rotated(randf()*TAU)
	emit_signal('spawn_bullet', position, direction)

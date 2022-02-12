extends Node2D
class_name Projectile



func setup(_pos: Vector2, _dir: Vector2):
	pass

func _enter_tree() -> void:
	$AnimationPlayer.play("active")


extends Node
class_name BaseAttack

signal attack_done
signal spawn_bullet(type, pos, dir)

func is_attack():
	return true

func start(_args: Array) -> void:
	emit_signal("attack_done")

func time(_args: Array) -> float:
	return 0.0

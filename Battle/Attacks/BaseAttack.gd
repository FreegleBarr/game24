extends Node
class_name BaseAttack

signal attack_done

func start(_args: Array) -> void:
	emit_signal("attack_done")

func time(_args: Array) -> float:
	return 0.0

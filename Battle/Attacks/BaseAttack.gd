extends Node
class_name BaseAttack

signal attack_done

func start(args: Array) -> void:
	emit_signal("attack_done")

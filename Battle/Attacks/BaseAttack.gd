extends Node
class_name BaseAttack

signal attack_done

func start() -> void:
	emit_signal("attack_done")

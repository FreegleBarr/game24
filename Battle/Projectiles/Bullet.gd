extends Area2D
class_name Bullet

export var move_speed: float = 100

var direction: Vector2
func _physics_process(delta: float) -> void:
	position += move_speed*direction*delta

func contact() -> void:
	get_parent().remove_child(self)

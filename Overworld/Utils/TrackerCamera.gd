extends Camera2D

export(NodePath) onready var tracked = get_node(tracked) as Node2D

var float_position = position
func _physics_process(delta: float) -> void:
	if tracked:
		float_position = lerp(position, tracked.position, delta*10)
		position = float_position.round()

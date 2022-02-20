extends Camera2D

export(NodePath) onready var tracked = get_node(tracked) as Node2D

var float_position = position
func _process(delta: float) -> void:
	if tracked:
		float_position = lerp(float_position, tracked.position, delta*2)
		position = float_position.round()

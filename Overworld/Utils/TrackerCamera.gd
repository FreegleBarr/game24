extends Camera2D

export(NodePath) var tracked
onready var _tracked = get_node_or_null(tracked)

var float_position = position
func _physics_process(delta: float) -> void:
	if _tracked:
		float_position = lerp(position, _tracked.position, delta*10)
		position = float_position.round()

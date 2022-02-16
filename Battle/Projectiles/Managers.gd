extends Node2D

func _ready() -> void:
	Battle.projectile_manager = self

	
func _on_spawn_bullet(type, pos, dir) -> void:
	type = "nerve shock"
	print("trying to spawn ", type, "at ", pos)
	if has_node(type.capitalize()):
		var manager: ProjectileManager = get_node(type.capitalize())
		manager.spawn_projectile(pos, dir)
	else:
		push_warning("tried to spawn " + type.capitalize() + " but has no manager")


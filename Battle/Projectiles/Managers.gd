extends Node2D


	
func _on_spawn_bullet(type, pos, dir) -> void:
	print("trying to spawn ", type, "at ", pos)
	if has_node(type.capitalize()):
		var manager: ProjectileManager = get_node(type.capitalize())
		manager.spawn_projectile(pos, dir)
	else:
		push_warning("tried to spawn " + type + " but has no manager")


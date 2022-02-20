extends Node2D
class_name ProjectileManager

export var projectile_count: int = 100

export(PackedScene) var ProjType


var Spawn = preload('res://Battle/Projectiles/Spawn.tscn')

var ProjectilePool := []

func _ready():
	assert(ProjType, "Unset Projectile Scene")
	for _i in range(projectile_count):
		var proj: Projectile = ProjType.instance()
		ProjectilePool.append(proj)

var current = 0
func spawn_projectile(pos, dir) -> void:
	assert(ProjType, "Unset Projectile Scene")
	var proj: Projectile = ProjectilePool[current]
	current += 1
	current %= projectile_count
	var parent: ProjectileManager = proj.get_parent()
	
	var spawn = Spawn.instance()
	spawn.position = pos
	add_child(spawn)
	yield(spawn, "animation_finished")
	if parent:
		parent.remove_child(proj)
	proj.setup(pos, dir)
	add_child(proj)
	

extends Node2D


func _ready():
	Battle.connect("spawn_enemy_object", self, "_on_spawn_object")
	pass

func _on_spawn_object(res, spawn_pos, angle):
	var obj = res.instance()
	obj.position = spawn_pos
	obj.rotation_degrees = angle
	add_child(obj)

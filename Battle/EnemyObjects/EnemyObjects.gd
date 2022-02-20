extends Node2D


func _ready():
	var err = Battle.connect("spawn_enemy_object", self, "_on_spawn_object")
	assert(err==OK, "Connection Error")

func _on_spawn_object(res, spawn_pos, angle):
	var obj = res.instance()
	obj.position = spawn_pos
	obj.rotation_degrees = angle
	add_child(obj)

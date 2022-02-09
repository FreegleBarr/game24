extends Node2D

var BulletPool = []
var Bullet = preload("res://Battle/Bullet.tscn")

var current = 0

func _ready():
	for i in range(100):
		var bullet = Bullet.instance()
		BulletPool.append(bullet)

func _on_0_spawn_bullet(pos, dir) -> void:
	var bullet: Bullet = BulletPool[current]
	var parent: Node = bullet.get_parent()
	if parent:
		parent.remove_child(bullet)
	bullet.position = pos
	bullet.direction = dir
	add_child(bullet)
	current += 1
	current %= 100
	
		

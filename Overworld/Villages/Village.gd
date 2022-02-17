extends Node2D

export(NodePath) onready var player = get_node(player) as KinematicBody2D

signal player_fallen(last_pos)

func _ready():
	connect("player_fallen", self, "_on_player_fallen")
	respawn_player()
	pass

func respawn_player(last_pos=Vector2()):
	if last_pos == Vector2():
		player.position = $SpawnPoint.position
	else:
		player.position = last_pos
	player.modulate = Color.white

func _on_player_fallen(last_pos:=Vector2()):
	respawn_player()

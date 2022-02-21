extends Node2D

export(NodePath) onready var player = get_node(player) as KinematicBody2D

export(PackedScene) var BattleScene

signal change_scene(target)
signal player_fallen(last_pos)
signal npc_interaction(b)

func _ready():
	Overworld.village = self
	connect("player_fallen", self, "_on_player_fallen")
	respawn_player()
	$SpawnPoint/Label.text = name
	var Map = load("res://Map/Map.tscn").instance()
	$CanvasLayer.add_child(Map)
	Map.hide()
	AudioHandler.change_sound_to("Village")

func respawn_player(last_pos:=Vector2()):
	if last_pos == Vector2():
		player.position = $SpawnPoint.position
	else:
		player.position = last_pos
	player.modulate = Color.white

func _on_player_fallen(last_pos:=Vector2()):
	respawn_player()

func start_battle():
	emit_signal("change_scene", BattleScene)

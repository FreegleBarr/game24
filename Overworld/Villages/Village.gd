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
	pass


func _on_Dialogic(arg):
	var current = int(Dialogic.get_variable("success"))
	print(arg, ": current -> ", current)
	if arg == "yes":
		Dialogic.set_variable("success", current + 1)
	elif arg == "reset_success":
		Dialogic.set_variable("success", 0)
	elif arg == "battle":
		print("battle?")
		emit_signal("change_scene", "brain_battle")
	
	if int(Dialogic.get_variable("success")) == 3:
		print("SUCCCESSSS!")
		remove_child($RightWalls)
		

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

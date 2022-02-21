extends "res://Overworld/Villages/NPC.gd"

signal battle_started

func dialogue_end(timeline_name):
	.dialogue_end(timeline_name)
	Overworld.village.call_deferred("start_battle")

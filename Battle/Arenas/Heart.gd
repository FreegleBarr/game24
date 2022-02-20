extends "res://Battle/Arenas/Arena.gd"

onready var warps = $Organ/Warps
onready var contour = $Organ/Contour

var open := true
func _ready() -> void:
	contour.play('default')
	warps.enabled = true


func _on_HeartBeatTimer_timeout() -> void:
	open = not open
	if open:
		contour.play('open')
		yield(contour, "frame_changed")
		warps.enabled = true
	else:
		contour.play('close')
		warps.enabled = false
		

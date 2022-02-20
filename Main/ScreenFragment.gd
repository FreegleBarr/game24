extends Node2D
class_name ScreenFragment

signal ended

export(Array, StreamTexture) var texts

var current := false
onready var tween := $Tween

func start():
	$Image.set("shader_param/show_time", float(OS.get_ticks_msec())/1000)
	for text in texts:
		yield(get_parent(), "next")
		tween.stop_all()
		$Text.modulate = Color(0)
		tween.interpolate_property($Text, "modulate",
				Color(0), Color(1), Tween.TRANS_LINEAR, Tween.EASE_OUT_IN)
		
	
	yield(get_parent(), "next")
	emit_signal("ended")

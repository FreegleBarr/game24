extends ColorRect

signal screen_hid
signal screen_shown

export var wait_timer := false

onready var timer: Timer = $Timer
onready var tween: Tween = $Tween

var showing := false

func _ready() -> void:
	visible = false
	
func show():
	showing = true
	tween.interpolate_property(self, "modulate",
			Color(0,0,0,0), Color(1,1,1,1), 0.5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()
	visible = true
	
	if wait_timer:
		timer.start()

func unshow():
	if wait_timer and not timer.is_stopped():
		yield(timer, "timeout")
	showing = false
	tween.interpolate_property(self, "modulate",
			Color(1,1,1,1), Color(0,0,0,0), 0.5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()

func _on_Tween_tween_completed(object: Object, key: NodePath) -> void:
	if showing:
		modulate = Color(1,1,1,1)
		emit_signal("screen_hid")
	else:
		modulate = Color(0,0,0,0)
		visible = false
		emit_signal("screen_shown")

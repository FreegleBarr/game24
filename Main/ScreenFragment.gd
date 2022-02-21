extends AspectRatioContainer
class_name ScreenFragment

signal ended

export(StreamTexture) var texture
export(Array, StreamTexture) var texts

var controller: Node2D = null
onready var tween := $Tween

func _ready() -> void:
	$Image.texture = texture

func start():
	assert(controller)
	$Image.material.set("shader_param/show_time", float(OS.get_ticks_msec())/1000)
#	for text in texts:
#		yield(get_parent(), "procceed")
#		tween.stop_all()
#		$Text.modulate = Color(0)
#		tween.interpolate_property($Text, "modulate",
#				Color(0), Color(1), Tween.TRANS_LINEAR, Tween.EASE_OUT_IN)
		
	yield(controller, "procceed")
	emit_signal("ended")

extends AudioStreamPlayer

export(float, -80, 24) var volume = 0

onready var tween = $Tween

func _ready() -> void:
	tween.interpolate_property(self, "volume_db",
		-80, volume, 0.5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()
	play()

func _on_MusicPlayer_finished() -> void:
	play()

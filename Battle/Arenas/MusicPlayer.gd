extends AudioStreamPlayer


func _ready() -> void:
	play()


func _on_MusicPlayer_finished() -> void:
	play()

extends Node

export (Array, String) var names = []
export (Array, AudioStream) var sounds = []

onready var fade_in = $FadeIn
onready var fade_out = $FadeOut
 
var bus = 0
var buses = []
var current_sound = ''
var fade_out_target_bus = 0
var fade_in_target_bus = 0
var fade_out_vol = 0
var fade_in_vol = 0
var faded_sound = ''

func _ready():
	AudioServer.add_bus()
	bus = AudioServer.bus_count - 1
	if len(names) != len(sounds):
		printerr("AudioHandler has different numbers of names and sounds")
		get_tree().quit()
	for i in range(len(sounds)):
		var player = AudioStreamPlayer.new()
		player.stream = sounds[i]
		player.name = names[i]
		add_child(player)
		player.play()
		AudioServer.add_bus()
		var b = AudioServer.bus_count - 1
		AudioServer.set_bus_name(b, names[i])
		AudioServer.set_bus_volume_db(b, linear2db(0))
		buses.append(b)
		player.set_bus(AudioServer.get_bus_name(b))
		AudioServer.set_bus_send(b, AudioServer.get_bus_name(bus))

func _index_of(sound_name):
	return names.find(sound_name)

func _bus_of(sound_name):
	return buses[_index_of(sound_name)]

func _sound(sound_name):
	return get_node(sound_name)


func _stop_faded_sound(_a, _b):
	_sound(faded_sound).stop()
	

func _fade_out(sound):
	faded_sound = sound
	fade_out_target_bus = _bus_of(sound)
	fade_out.interpolate_property(self, "fade_out_vol", 1, 0, .5, Tween.TRANS_LINEAR, Tween.EASE_IN)
	fade_out.start()

func _fade_in(sound):
	_sound(sound).play()
	fade_in_target_bus = _bus_of(sound)
	fade_in.interpolate_property(self, "fade_in_vol", 0, 1, .5, Tween.TRANS_LINEAR, Tween.EASE_IN)
	fade_in.start()

func change_sound_to(sound):
	if sound == current_sound:
		print("not changing")
		return
	if current_sound != '':
		_fade_out(current_sound)
	current_sound = sound
	_fade_in(current_sound)

func stop_all_sound():
	if current_sound == '':
		return
	_fade_out(current_sound)
	current_sound = ''

func _process(_delta):
	if fade_out_target_bus != 0:
		AudioServer.set_bus_volume_db(fade_out_target_bus, linear2db(fade_out_vol))
	if fade_in_target_bus != 0:
		AudioServer.set_bus_volume_db(fade_in_target_bus, linear2db(fade_in_vol))


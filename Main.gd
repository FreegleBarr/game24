extends Node2D

#Set to title if not debugging
export(String, "title", "intro", "eye_battle", "brain_village", "brain_battle") var selected_scene

var Title := preload("res://Main/TitleScreen.tscn")
var Intro := preload("res://Main/Intro.tscn")
var EyeBattle := preload("res://Battle/Arenas/Eye.tscn")
var BrainVillage := preload("res://Overworld/Villages/Brain.tscn")
var BrainBattle := preload("res://Battle/Arenas/Brain.tscn")

onready var loading := $CanvasLayer/LoadingScreen
onready var current_scene := $Splash

var scenes := {
	'title': Title,
	'intro': Intro,
	'eye_battle': EyeBattle,
	'brain_village': BrainVillage,
	'brain_battle': BrainBattle
}


func _ready() -> void:
	$Splash.call_deferred("show")
	yield($Splash, "splash_done")
	_on_change_scene(selected_scene)

func _on_change_scene(target: String) -> void:
	loading.show()
	get_tree().paused = true
	yield(loading, "screen_hid")
	var packed: PackedScene
	if scenes.has(target):
		packed = scenes[target]
	else:
		packed = load(target)

	current_scene.queue_free()
	current_scene = packed.instance()
	current_scene.pause_mode = Node.PAUSE_MODE_STOP
	call_deferred('add_child', current_scene)
	yield(current_scene, "tree_entered")
	current_scene.connect("change_scene", self, "_on_change_scene")
	loading.unshow()
	yield(loading, "screen_shown")
	get_tree().paused = false

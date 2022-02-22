extends Node2D

signal procceed
signal change_scene(target)

export(Array, NodePath) var pages
onready var tween: Tween = $Tween

export(Array, String, MULTILINE) var subtitles
var current_subtitle := 0

func advance_subtitle():
	$CanvasLayer/VBoxContainer/Subtitle.text = subtitles[current_subtitle]
	current_subtitle += 1


func _ready() -> void:
	
	for t in subtitles:
		print(t)
	
	
	
	for i in range(pages.size()):
		pages[i] = get_node(pages[i])
	for page in pages:
		for row in page.get_children():
			row.controller = self
	call_deferred("run")
	

func run():
	for _page in pages:
		var page = _page as CenterContainer
		for _row in page.get_children():
			var row = _row as CenterContainer
			row.start()
			yield(row, "done")
			$Camera2D.position.y += (1000)/(page.get_child_count())
		$Camera2D.position.y = -150 # HELP ME FREEGLE!
		tween.interpolate_property(page, "modulate",
			Color(1,1,1,1), Color(0,0,0,0), 0.5, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		tween.start()
		yield(tween, "tween_all_completed")
		tween.stop_all()
		page.visible = false
	emit_signal('change_scene', "eye_battle")
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("interact"):
		emit_signal("procceed")

extends Node2D

signal procceed
signal change_scene(target)

export(Array, NodePath) var pages
onready var tween: Tween = $Tween

func _ready() -> void:
	for i in range(pages.size()):
		pages[i] = get_node(pages[i])
	for page in pages:
		for row in page.get_children():
			row.controller = self
	call_deferred("run")

func run():
	for page in pages:
		for row in page.get_children():
			row.start()
			yield(row, "done")
			$Camera2D.position.y += (1000-720)/(page.get_child_count()-1)
		$Camera2D.position.y = 0
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

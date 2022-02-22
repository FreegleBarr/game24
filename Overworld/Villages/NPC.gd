tool
extends Area2D

export(Texture) var SpriteTexture setget set_texture
export(int, 1, 15) var FrameCount := 1 setget set_frame_count
export(Array, String, "TimelineDropdown") var dialogues


var dialogue_index := 0
var d_node
var selected := false setget set_selected

var interacting := false setget set_interacting

func set_texture(t:Texture):
	SpriteTexture = t
	if get_node_or_null("Sprite"):
		$Sprite.texture = t
	set_frame_count(FrameCount)
	
func set_frame_count(i:int):
	i = max(i,1)
	FrameCount = i
	if get_node_or_null("Sprite"):
		$Sprite.hframes = FrameCount

func _ready():
	set_selected(false)
	set_interacting(false)
	set_texture(SpriteTexture)
	

func _on_Dialogic(arg:String):
	owner._on_Dialogic(arg)
	print(name, ": ", arg)
	dialogue_index += 1
	dialogue_index %= int(max(1,dialogues.size()))
	if current_dialogue():
		Dialogic.start(current_dialogue())

func _input(event):
	if not selected: return
	if Input.is_action_just_pressed("interact"):
		if interacting or not current_dialogue():
			return
		
		d_node = Dialogic.start(current_dialogue())
		add_child(d_node)
		d_node.connect("timeline_end", self, "dialogue_end")
		d_node.connect("dialogic_signal", self, "_on_Dialogic")
		
		set_interacting(true)
		owner.emit_signal("npc_interaction", interacting)

func current_dialogue():
	if dialogue_index < dialogues.size():
		return dialogues[dialogue_index]

	

func dialogue_end(timeline_name):
	set_interacting(false)
	owner.emit_signal("npc_interaction", false)


func set_interacting(b:bool):
	interacting = b
#	$Label.visible = b

func set_selected(b:bool):
	selected = b
	if b:
		$KeyPrompt.play()
		$KeyPrompt.show()
	else:
		$KeyPrompt.hide()
		$KeyPrompt.stop()

func select():
	set_selected(true)

func deselect():
	set_selected(false)


func _on_SpriteTimer_timeout():
	$Sprite.frame = ($Sprite.frame + 1) % $Sprite.hframes
	pass

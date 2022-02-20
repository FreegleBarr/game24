extends KinematicBody2D

var velocity := Vector2.ZERO
var speed: float = 50
var acceleration: float = 50
var deceleration: float = 50
var maxSpeed: float = 10

var talking := false

var accepting_inputs := true

func _ready():
	owner.connect("npc_interaction", self, "_on_npc_interaction")


func _on_npc_interaction(b):
	accepting_inputs = not b

func _physics_process(delta):
	
	if not accepting_inputs:
		return 
		
	var xInput = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	var yInput = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up") 
	
	velocity += Vector2(xInput, yInput).normalized()*acceleration*delta
	
	#complex code, but basically decrease speed until it's smaller than deceleration
	#in which case set it to zero
	if xInput == 0:
		velocity.x -= sign(velocity.x)*min(abs(velocity.x), deceleration*delta)
	elif xInput > 0:
		$Sprite.flip_h = false
	else:
		$Sprite.flip_h = true

	if yInput == 0:
		velocity.y -= sign(velocity.y)*min(abs(velocity.y), deceleration*delta)
	
	velocity = velocity.normalized()*min(velocity.length(), maxSpeed)
	
	velocity = move_and_slide(velocity*speed)
	position = position.round()
	velocity /= speed

extends KinematicBody2D

var velocity = Vector2.ZERO
var speed = 50
var acceleration = 50
var deceleration = 50
var maxSpeed = 10


func _physics_process(delta):
	
	var xInput = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	var yInput = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up") 
	
	velocity += Vector2(xInput, yInput).normalized()*acceleration*delta
	
	#complex code, but basically decrease speed until it's smaller than deceleration
	#in which case set it to zero
	if xInput == 0:
		velocity.x -= sign(velocity.x)*min(abs(velocity.x), deceleration*delta)
				
	if yInput == 0:
		velocity.y -= sign(velocity.y)*min(abs(velocity.y), deceleration*delta)
	
	velocity = velocity.normalized()*min(velocity.length(), maxSpeed)
	
	velocity = move_and_slide(velocity*speed)
	velocity /= speed


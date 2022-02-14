extends KinematicBody2D

var velocity = Vector2.ZERO
var speed = 50
var acceleration = 0.5
var deceleration = 0.5
var maxSpeed = 10


func _process(delta):
	
	var xInput = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	var yInput = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up") 
	
	if Input.is_action_pressed("ui_right"):
		velocity.x += acceleration
	if Input.is_action_pressed("ui_left"):
		velocity.x -= acceleration
	if Input.is_action_pressed("ui_down"):
		velocity.y += acceleration
	if Input.is_action_pressed("ui_up"):
		velocity.y -= acceleration
		
	if xInput == 0:
		if velocity.x != 0:
			if velocity.x < 0:
				velocity.x += deceleration
			if velocity.x > 0:
				velocity.x -= deceleration
				
	if yInput == 0:
		if velocity.y != 0:
			if velocity.y < 0:
				velocity.y += deceleration
			if velocity.y > 0:
				velocity.y -= deceleration
				
	velocity.x = clamp(velocity.x, -maxSpeed, maxSpeed)
	velocity.y = clamp(velocity.y, -maxSpeed, maxSpeed)
	
	move_and_slide(velocity*speed)


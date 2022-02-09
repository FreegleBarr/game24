extends KinematicBody2D

signal died

export var move_speed = 400

export var max_hp = 3 setget change_max_hp
func change_max_hp(value):
	max_hp = min(value, 0)
	#call hp setter
	self.hp = min(hp, max_hp)


#do not onready
var hp setget change_hp
func change_hp(value):
	hp = min(max_hp, value)
	if hp <= 0:
		#TODO: die
		emit_signal("died")
		$Label.text = "Dead"

var velocity: Vector2
func _physics_process(delta: float) -> void:
	velocity = Vector2()
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	
	move_and_slide(velocity * move_speed)


func _on_Button_button_down() -> void:
	self.hp = -9999

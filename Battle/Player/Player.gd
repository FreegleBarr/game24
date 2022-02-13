extends KinematicBody2D

signal died
signal hp_changed(value)

export var move_speed = 400

var dead: bool = false

onready var playback = $AnimationTree.get('parameters/playback')

export var max_hp = 3 setget change_max_hp
func change_max_hp(value):
	max_hp = min(value, 0)
	#call hp setter
	self.hp = min(hp, max_hp)


#do not onready
var hp setget change_hp
func change_hp(value):
	hp = min(max_hp, value)
	emit_signal("hp_changed", hp)
	if hp <= 0:
		emit_signal("died")
		die()

func _ready() -> void:
	self.hp = max_hp
	
var velocity: Vector2
func _physics_process(_delta: float) -> void:
	velocity = Vector2()
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
		
	if dead:
		pass
	elif velocity:
		if velocity.x > 0:
			$Sprite.flip_h = false
		elif velocity.x < 0:
			$Sprite.flip_h = true
#		playback.travel("Move")
		velocity = move_and_slide(velocity * move_speed)
	else:
		pass
#		playback.travel("Idle")

func die():
	#TODO: die
	playback.travel("Dead")
	dead = true
	$Collision.set_deferred("disabled", true)
	$Hurtbox/Collision.set_deferred("disabled", true)


func _on_Button_button_down() -> void:
	self.hp = -9999


func _on_Hurtbox_area_entered(area: Area2D) -> void:
	area.owner.contact()
	playback.travel("Hurt")
	self.hp -= 1

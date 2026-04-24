extends CharacterBody2D

@export var SPEED = 100.0
@export var JUMP_VELOCITY = -250

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var anim = $AnimatedSprite2D
@onready var animPlayer = $AnimationPlayer

var health = 100
var state = "MOVE"
var is_attacking = false
var key = 0


func _physics_process(delta: float) -> void:


	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		if velocity.y > 0:
			velocity.y = 0


	if not is_attacking:
		move_state()

	move_and_slide()



func move_state():

	
	if Input.is_action_just_pressed("attack"):
		start_attack()
		return

	var direction := Input.get_axis("ui_left", "ui_right")

	if direction != 0:
		velocity.x = direction * SPEED
		animPlayer.play("run")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		animPlayer.play("idle")

	if direction == -1:
		anim.flip_h = true
	elif direction == 1:
		anim.flip_h = false

	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		animPlayer.play("jump")

	if velocity.y > 0 and not is_on_floor():
		animPlayer.play("fall")



func start_attack():

	if is_attacking:
		return

	is_attacking = true
	velocity.x = 0

	animPlayer.play("Attack")

	await animPlayer.animation_finished

	is_attacking = false

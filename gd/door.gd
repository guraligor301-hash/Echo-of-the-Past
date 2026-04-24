extends Node2D

var player_nearby := false
var is_open := false

@onready var anim = $AnimatedSprite2D
@onready var audio = $AudioStreamPlayer2D
@onready var collision = $CollisionShape2D

var sounds = {
	"open": preload("res://sound/soundreality-opening-door-411632.mp3"),
	"close": preload("res://sound/soundreality-door-closing-2-455060.mp3")
}

func _ready():
	$Area2D.body_entered.connect(_on_body_entered)
	$Area2D.body_exited.connect(_on_body_exited)

func _process(_delta):
	if player_nearby and Input.is_action_just_pressed("interact1"):
		toggle_door()

func _on_body_entered(body):
	if body.is_in_group("player"):
		player_nearby = true

func _on_body_exited(body):
	if body.is_in_group("player"):
		player_nearby = false

func toggle_door():
	if is_open:
		close_door()
	else:
		open_door()

func open_door():
	is_open = true
	anim.play("open")
	audio.stream = sounds["open"]
	audio.play()

	_set_collision(false)

func close_door():
	is_open = false
	anim.play("close")
	audio.stream = sounds["close"]
	audio.play()

	_set_collision(true)

func _set_collision(enabled: bool):
	if collision:
		collision.call_deferred("set_disabled", not enabled)

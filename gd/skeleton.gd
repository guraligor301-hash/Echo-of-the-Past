extends CharacterBody2D


var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")	

var chase = false
var speed = 250

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		var player = $"../player"
		var direction = (player.position - self.position).normalized()
		if chase == true:
			velocity.x = direction.x * speed
			velocity.y = direction.y * speed
			$AnimatedSprite2D.flip_h = direction.x < 0
		else:
			velocity.x = 0
				
	move_and_slide()


func _on_detector_body_entered(body):
	if body.name == "player":
		chase = true


func _on_detector_body_exited(body):
	if body.name == "player":
		chase = false

extends KinematicBody2D

# movement variables
var moveSpeed : int = 250
var vel : Vector2 = Vector2()
var facingDir : Vector2 = Vector2()

onready var anim = get_node("AnimatedSprite")

func _physics_process(delta):
	vel = Vector2()
	
	# inputs
	if Input.is_action_pressed("move_up"):
		vel.y -= 1
		facingDir = Vector2(0, -1)
	if Input.is_action_pressed("move_down"):
		vel.y += 1
		facingDir = Vector2(0, 1)
	if Input.is_action_pressed("move_left"):
		vel.x -= 1
		facingDir = Vector2(-1, 0)
	if Input.is_action_pressed("move_right"):
		vel.x += 1
		facingDir = Vector2(1, 0)
		
	# normalization
	vel = vel.normalized()
	
	# move the player
	move_and_slide(vel * moveSpeed)
	
	manage_animations()


func manage_animations():
	if vel.x > 0:
		play_animation("MoveRight")
	elif vel.x < 0:
		play_animation("MoveLeft")
	elif vel.y < 0:
		play_animation("MoveUp")
	elif vel.y > 0:
		play_animation("MoveDown")
	elif facingDir.x == 1:
		play_animation("IdleRight")
	elif facingDir.x == -1:
		play_animation("IdleLeft")
	elif facingDir.y == -1:
		play_animation("IdleUp")
	elif facingDir.y == 1:
		play_animation("IdleDown")
		
func play_animation(anim_name):
	if anim.animation != anim_name:
		anim.play(anim_name)
	
	

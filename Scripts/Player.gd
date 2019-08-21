extends KinematicBody2D

# Initial Declarations
export (int) var speed = 200
var velocity = Vector2()
var sprinting = false
onready var anim = $AnimationPlayer
onready var sprite = $Sprite

# Main Physics Loop
func _physics_process(delta):
	_get_input()
	_movement_hanlder()
	_sprite_handler()
	velocity = move_and_slide(velocity)

# Helper functions
func _get_input():
	velocity = Vector2()
	sprinting = _is_sprinting()
	
	if Input.is_action_pressed("up"):
		velocity.y -= 1
	if Input.is_action_pressed("down"):
		velocity.y += 1
	if Input.is_action_pressed("left"):
		velocity.x -= 1
	if Input.is_action_pressed("right"):
		velocity.x += 1

func _movement_hanlder():
	if sprinting:
		velocity = velocity.normalized() * speed * 2
	else:
		velocity = velocity.normalized() * speed

func _sprite_handler():
	var moving = velocity != Vector2.ZERO
	if sprinting && moving:
		anim.play("run")
	elif !sprinting && moving:
		anim.play("walk")
	else:
		anim.stop(false)
		
	if Input.is_action_pressed("right"):
		sprite.flip_h = false
	if Input.is_action_pressed("left"):
		sprite.flip_h = true

func _is_sprinting():
	return Input.is_action_pressed("sprint")
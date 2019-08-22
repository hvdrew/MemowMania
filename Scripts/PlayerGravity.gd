extends KinematicBody2D

# Exports
export (int) var run_speed = 200
export (int) var jump_speed = -400
export (int) var gravity = 1200
export (bool) var sprinting_enabled = true

# On Ready variables
onready var anim = $AnimationPlayer
onready var sprite = $Sprite

# Initialization
var velocity = Vector2()
var sprinting = false
var jumping = false

func get_input():
	velocity.x = 0
	var right = Input.is_action_pressed("right")
	var left = Input.is_action_pressed("left")
	var jump = Input.is_action_pressed("jump")
	sprinting = Input.is_action_pressed("sprint")
	
	if sprinting_enabled:
		if jump and is_on_floor():
			jumping = true
			velocity.y = jump_speed
		if right:
			if sprinting:
				velocity.x += run_speed * 2
			else:
				velocity.x += run_speed
		if left:
			if sprinting:
				velocity.x -= run_speed * 2
			else:
				velocity.x -= run_speed
	else:
		if jump and is_on_floor():
			jumping = true
			velocity.y = jump_speed
		if right:
			velocity.x += run_speed
		if left:
			velocity.x -= run_speed

func sprite_handler():
	if sprinting_enabled:
		sprinting_sprite_handler()
	else:
		normal_sprite_handler()
	
	if Input.is_action_pressed("right"):
		sprite.flip_h = false
	if Input.is_action_pressed("left"):
		sprite.flip_h = true
	
	if not is_on_floor():
		anim.stop(false)

func sprinting_sprite_handler():
	if sprinting and velocity.x != 0:
		anim.play("run")
	elif not sprinting && velocity.x != 0:
		anim.play("walk")
	else:
		anim.stop(false)

func normal_sprite_handler():
	if velocity.x != 0:
		anim.play("run")
	else:
		anim.stop(false)

func _physics_process(delta):
	get_input()
	sprite_handler()
	
	velocity.y += gravity * delta
	if jumping and is_on_floor():
		jumping = false
	
	velocity = move_and_slide(velocity, Vector2(0, -1))
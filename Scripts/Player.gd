"""
TODO:
	Split functions up a bit more
	Make this function better in general
"""

extends KinematicBody2D

export (int) var speed = 200
var velocity = Vector2()
onready var anim = $AnimationPlayer
onready var sprite = $Sprite

func get_input():
	velocity = Vector2()
	var sprinting = is_sprinting()
	
	if Input.is_action_pressed("up"):
		velocity.y -= 1
	if Input.is_action_pressed("down"):
		velocity.y += 1
	if Input.is_action_pressed("left"):
		velocity.x -= 1
		sprite.flip_h = true
	if Input.is_action_pressed("right"):
		velocity.x += 1
		sprite.flip_h = false
	
	if sprinting:
		velocity = velocity.normalized() * speed * 2
		anim.play("run")
	else:
		velocity = velocity.normalized() * speed
		anim.play("walk")
	
	if velocity == Vector2.ZERO:
		anim.stop(false)


func _physics_process(delta):
	get_input()
	velocity = move_and_slide(velocity)
	
func is_sprinting():
	return Input.is_action_pressed("sprint")
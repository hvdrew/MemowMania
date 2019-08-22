extends CanvasLayer

func _physics_process(delta):
	if Input.is_action_pressed("restart"):
		get_tree().change_scene("res://Scenes/Main.tscn")
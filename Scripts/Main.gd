extends Node

onready var player = $Player
onready var coin = $Coin
onready var fall_dectector = $FallDetector

signal game_over
signal game_won

func _ready():
	coin.connect("body_entered", self, "on_Coin_entered")
	fall_dectector.connect("body_entered", self, "on_Fall")

func on_Coin_entered(arg):
	$Coin.queue_free()
	emit_signal("game_won")
	get_tree().change_scene("res://Scenes/Win.tscn")

func on_Fall(arg):
	emit_signal("game_over")
	get_tree().change_scene("res://Scenes/Lose.tscn")
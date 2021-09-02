extends Node2D

const speed = -750

func _ready():
	pass # Replace with function body.

func _process(delta):
	position += Vector2(0,delta * speed)

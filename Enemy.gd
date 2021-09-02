extends Node2D

onready var Global = get_node("/root/Global")
var speed = 200
var width = 800

func _ready():
	Global.score += 0

func do_movement(delta):
	position += Vector2(speed*delta,0)
	if (position.x > width):
		speed = -speed
		position += Vector2(speed*delta,0)
	if (position.x < 0):
		speed = -speed
		position += Vector2(speed*delta,0)

func _process(delta):
	do_movement(delta)

func _on_Area2D_area_entered(area):
	if(area.is_in_group("Bullet")):
		area.get_parent().queue_free()
		self.queue_free()
		Global.score += 1
		print(Global.score)
		

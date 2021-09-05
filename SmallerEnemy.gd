extends Node2D

onready var Global = get_node("/root/Global")
var speed = Vector2(100,50)
var width = 800
var current_rotation = 1
var enemyWidth = 20

func _ready():
	Global.score += 0
	for c in get_children():
		c.add_to_group("Enemy")

func do_movement(delta):
	position += speed*delta
	if (position.x > width):
		speed.x = -speed.x
		position += speed*delta
	if (position.x < 0):
		speed.x = -speed.x
		position += speed*delta
	if position.x >= Global.right_border_x-enemyWidth:
		current_rotation = -current_rotation
	position.x = clamp(position.x, Global.left_border_x, Global.right_border_x-enemyWidth)
	
func rotation():
	var max_rotation = 180
	if rad2deg( speed.angle()) < max_rotation :
		speed = speed.rotated(deg2rad(current_rotation))
	else:
		current_rotation = -current_rotation
	if speed.y > 0:
		speed.y = 50

func _process(delta):
	rotation()
	do_movement(delta)

func _on_Area2D_area_entered(area):
	if(area.is_in_group("Bullet")):
		area.get_parent().queue_free()
		self.queue_free()
		Global.score += 1
		print(Global.score)
		

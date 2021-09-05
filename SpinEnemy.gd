extends Node2D

var rotation_speed = 180
var speed = Vector2(0,50)
var canShoot = false

func _ready():
	position = Vector2(400,200)

func do_movement(delta):
	position += speed*delta
	
func try_shoot():
	pass

func _process(delta):
	do_movement(delta)
	set_global_rotation_degrees(get_global_rotation_degrees() + rotation_speed*delta)
	try_shoot()
	#make function that shoots towards player position
	#need to set timer for shooting
	#conect timer to shooter
	#might have to expose player position in global?


func _on_Area2D_area_entered(area):
	if(area.is_in_group("Bullet")):
		area.get_parent().queue_free()
		self.queue_free()
		Global.score += 1
		print(Global.score)

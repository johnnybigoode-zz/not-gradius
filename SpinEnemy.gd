extends Node2D

var rotation_speed = 180
var speed = Vector2(0,50)
var canShoot = false
var Bullet = load("res://Bullet.tscn")
var shoot_delay = 0.5

func _ready():
	shoot_timer()

func do_movement(delta):
	position += speed*delta
	
func try_shoot():
	var player = Global.player
	if is_instance_valid(player) && canShoot:
		var position_to_aim = player.position - Vector2(-20,0)
		var direction = (position_to_aim - self.position).normalized()
		var b = Bullet.instance()
		b.set_children_group("EnemyBullet")
		b.direction = direction
		b.position = Vector2(get_position()) + Vector2(0,30)
		b.speed = -0.5*(b.speed)
		get_parent().add_child(b)
		b.set_color(Color( 1, 0.08, 0.58, 1 ))
		canShoot = false

func allow_shoot():
	canShoot = true

func shoot_timer():
	var timer = Timer.new()
	add_child(timer)
	timer.set_wait_time(shoot_delay)
	timer.connect("timeout", self, "allow_shoot")
	timer.start()

func _process(delta):
	if(position.y > 600):
		self.queue_free()
	do_movement(delta)
	set_global_rotation_degrees(get_global_rotation_degrees() + rotation_speed*delta)
	try_shoot()
	#need to set timer for shooting
	#conect timer to shooter
	#might have to expose player position in global?


func _on_Area2D_area_entered(area):
	if(area.is_in_group("Bullet")):
		area.get_parent().queue_free()
		self.queue_free()
		Global.score += 1
		print(Global.score)

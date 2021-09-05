extends Node2D

var Bullet = load("res://Bullet.tscn")
onready var Global = get_node("/root/Global")

const speed = 600
var hasShot = 0
var shipWidth = 40
var bullet_color = Color( 0, 1, 1, 1 )
# Called when the node enters the scene tree for the first time.
func _ready():
	position =  + Vector2(507,540)

func _process(delta):
	Global.player = self
	
	if Input.is_action_pressed("ui_left"):
		position -= Vector2(delta * speed,0)
	if Input.is_action_pressed("ui_right"):
		position += Vector2(delta * speed,0)
		
	position.x = clamp(position.x, Global.left_border_x-(shipWidth/4), Global.right_border_x-(shipWidth-shipWidth/4))
	if Input.is_action_pressed("ui_accept"):
		if(hasShot <= 0):
			hasShot = 10
			var b = Bullet.instance()
			b.position = Vector2(get_position()) + Vector2(shipWidth/2,0)
			get_parent().add_child(b)
			b.set_color(bullet_color)

	hasShot -= 1


func _on_Area2D_area_entered(area):
	if(area.is_in_group("Enemy") || area.is_in_group("Bullet")):
		area.get_parent().queue_free()
		self.queue_free()
	

extends Node2D

const speed = 300
var Bullet = load("res://Bullet.tscn")
var hasShot = 0
var shipWidth = 40
# Called when the node enters the scene tree for the first time.
func _ready():
	position =  + Vector2(507,540)


func _process(delta):
	if Input.is_action_pressed("ui_left"):
		position -= Vector2(delta * speed,0)
	if Input.is_action_pressed("ui_right"):
		position += Vector2(delta * speed,0)
	if Input.is_action_pressed("ui_accept"):
		if(hasShot <= 0):
			hasShot = 10
			var b = Bullet.instance()
			b.position = Vector2(get_position()) + Vector2(shipWidth/2,0)
			get_parent().add_child(b)

	hasShot -= 1

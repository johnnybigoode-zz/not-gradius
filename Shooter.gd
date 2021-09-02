extends Node2D

const speed = 300
var Bullet = load("res://Bullet.tscn")
var hasShot = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	if Input.is_action_pressed("ui_left"):
		position -= Vector2(delta * speed,0)
	if Input.is_action_pressed("ui_right"):
		position += Vector2(delta * speed,0)
	if Input.is_action_pressed("ui_accept"):
		if(hasShot <= 0):
			hasShot = 10
			var b = Bullet.instance()
			b.position = get_position() + Vector2(507,540)
			get_parent().add_child(b)

	hasShot -= 1

extends Node2D

var speed = -750
var child_color_rect = null
var direction = Vector2(0,1).normalized()

func _ready():
	set_children_group("Bullet")
	for c in get_children():
		if c is ColorRect:
			child_color_rect = c
			
		

func set_children_group(g):
	for c in get_children():
		c.add_to_group(g)

func set_color(color):
	child_color_rect.color = color
	#Color( 1, 0.08, 0.58, 1 )

func _process(delta):
	position += direction * speed * delta
	if(position.y < -10):
		self.queue_free()


func _on_Area2D_area_entered(area):
	print(area)

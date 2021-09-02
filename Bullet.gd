extends Node2D

const speed = -750

func _ready():
	for c in get_children():
		c.add_to_group("Bullet")

func _process(delta):
	position += Vector2(0,delta * speed)
	if(position.y < -10):
		self.queue_free()


func _on_Area2D_area_entered(area):
	print(area)

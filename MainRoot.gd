extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	enemy_factory()
	

var Enemy = load("res://Enemy.tscn")
var timer = null
var enemy_delay = 1
var row_width = 60

func enemy_factory():
	timer = Timer.new()
	add_child(timer)
	timer.set_wait_time(enemy_delay)
	timer.connect("timeout", self, "spawn_enemy")
	timer.start()
	
func spawn_enemy():
	var e = Enemy.instance()
	var row = int(rand_range(0, 3)) * row_width
	var randHorizontalPos = Vector2(rand_range(0, 600),row+20)
	e.position = randHorizontalPos
	get_parent().add_child(e)

func enemy_died_handler():
	print("enemy has died")

func _process(delta):
	if(Input.is_action_pressed("ui_cancel")):
		get_tree().reload_current_scene()

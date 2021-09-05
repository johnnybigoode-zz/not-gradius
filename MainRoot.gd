extends Node2D

var Enemy = load("res://Enemy.tscn")
var SmallerEnemy = load("res://SmallerEnemy.tscn")
var SpinEnemy = load("res://SpinEnemy.tscn")
var Border = load("res://Borders.tscn")

onready var Global = get_node("/root/Global")

var timer = null
var enemy_delay = 1
var row_width = 60

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	add_bounds()
	enemy_factory()

func add_bounds():
	var border_left = Border.instance()
	var border_right = Border.instance()
	border_left.position = Vector2(Global.left_border_x-Global.border_width,0)
	border_right.position = Vector2(Global.right_border_x,0)
	add_child(border_left)
	add_child(border_right)

func enemy_factory():
	timer = Timer.new()
	add_child(timer)
	timer.set_wait_time(enemy_delay)
	timer.connect("timeout", self, "spawn_enemy")
	timer.start()	
	
var spawn_list = ["spawn_three_spinners","spawn_several_small_enemies","spawn_five_enemies","spawn_three_spinners"]

func spawn_three_spinners():
	for n in 25:
		spawn_single_enemy(SpinEnemy)

func spawn_several_small_enemies():
	for n in 25:
		spawn_single_enemy(SmallerEnemy)

func spawn_five_enemies():
	for n in 5:
		spawn_single_enemy(Enemy)

func spawn_single_enemy(type_to_spawn):
	var e = type_to_spawn.instance()
	var row = int(rand_range(0, 3)) * row_width
	var spawn_x_pos = clamp(rand_range(0, 600),Global.left_border_x,Global.right_border_x)
	var randHorizontalPos = Vector2(spawn_x_pos,row+20)
	e.position = randHorizontalPos
	get_parent().add_child(e)

func spawn_enemy():
	var get_current = spawn_list.pop_front()	
	if get_current:
		call(get_current)

func enemy_died_handler():
	print("enemy has died")

func _process(delta):
	if(Input.is_action_pressed("ui_cancel")):
		get_tree().reload_current_scene()

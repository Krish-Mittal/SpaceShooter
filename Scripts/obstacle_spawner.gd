extends Node2D

var ENEMY_SCENE = preload("uid://sijd8jahgrlv")
var OBSTACLE_SCENE_1 = preload("uid://cyxkirl2332r1")

@onready var point_1: Marker2D = $Point1
@onready var point_2: Marker2D = $Point2
@onready var spawn_timer: Timer = $SpawnTimer


func _ready() -> void:
	GameManager.game_started.connect(spawn_timer.start)

func spawn_enemy():
	var enemy = ENEMY_SCENE.instantiate()
	enemy.position = get_random_pos(point_1, point_2)
	add_child(enemy)
	spawn_timer.start()
	enemy.get_node("Gun").shoot()

func spawn_obstacle():
	var obstacle = OBSTACLE_SCENE_1.instantiate()
	obstacle.position = get_random_pos(point_1,point_2)
	add_child(obstacle)
	spawn_timer.start()

func _on_spawn_timer_timeout() -> void:
	if(GameManager.game_state != GameManager.GameStates.On): return
	var randomizer = randi_range(1,2)
	match randomizer:
		1: spawn_enemy()
		2: spawn_obstacle()

func get_random_pos(p1, p2) -> Vector2:
	var point = Vector2(
		randf_range(p1.position.x,p2.position.x),
		randf_range(p1.position.y, p2.position.y)
	)
	return point
	

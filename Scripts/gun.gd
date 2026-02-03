extends Node2D

var shoot_mode : int = 1
var BULLET_SCENE = preload("uid://c41xw7t0fc413")
@export var team : GameManager.Team
@onready var shoot_timer: Timer = $ShootTimer
var shoot_time : float = 1.0
func _ready() -> void:
	GameManager.game_started.connect(shoot)
	shoot_timer.wait_time = shoot_time
	

func _input(event: InputEvent) -> void:
	if team != GameManager.Team.Player: return
	if(event.is_action_pressed("shoot")):
		shoot_mode = 1
	elif(event.is_action_pressed("shoot_triple")):
		shoot_mode = 2

func shoot_bullets(dir, rot, pos):
	var bullet = BULLET_SCENE.instantiate()
	bullet.team = team
	bullet.dir = dir
	bullet.pos = pos
	bullet.rot = rot
	bullet.speed = -1500 if(team == GameManager.Team.Player) else 800
	get_tree().root.get_node("Main").get_node("Bullets").add_child(bullet)


func shoot_triple_bullets():
	var r = 50
	shoot_bullets(rotation, global_rotation,global_position)
	shoot_bullets(rotation+r, global_rotation+r,global_position)
	shoot_bullets(rotation-r, global_rotation-r,global_position)


func shoot():
	if(GameManager.game_state != GameManager.GameStates.On): 
		return
	shoot_timer.start()
	match shoot_mode:
		1 : shoot_bullets(rotation,global_rotation, global_position)
		2 : shoot_triple_bullets()
		_ : return

func _on_shoot_timer_timeout() -> void:
	shoot()

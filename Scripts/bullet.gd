extends RigidBody2D

@onready var lifetime_timer: Timer = $LifetimeTimer
@onready var hitbox: HitboxComponent = $HitboxComponent

var pos : Vector2
var dir : float
var rot : float
var team: GameManager.Team
@export var speed = -1000

func _ready() -> void:
	hitbox.team = team
	global_position = pos
	global_rotation = rot
	lifetime_timer.one_shot = true
	lifetime_timer.start()

func _physics_process(_delta: float) -> void:
	linear_velocity = Vector2(0,speed).rotated(dir)

func _on_lifetime_timer_timeout() -> void:
	self.queue_free()

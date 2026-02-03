class_name Enemy extends RigidBody2D

const SPEED = 30.0
@onready var sprite: Sprite2D = $Sprite
@onready var health_component: HealthComponent = $HealthComponent
@onready var hurtbox_component: HurtboxComponent = $HurtboxComponent
@onready var gun: Node2D = $Gun

func _ready() -> void:
	health_component.died.connect(death)
	hurtbox_component.received_damage.connect(damage)
	var randomizer = randi_range(1,4)
	if(randomizer == 3): gun.shoot_mode = 2
	else: gun.shoot_mode = 1
	gun.shoot_timer.wait_time = 2.0

func _physics_process(_delta: float) -> void:
	linear_velocity.y = SPEED

func death():
	queue_free()
	
func damage():
	sprite.modulate = Color.RED
	await get_tree().create_timer(0.1).timeout
	sprite.modulate = Color.WHITE

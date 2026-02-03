class_name Obstacle extends RigidBody2D

@onready var sprite: Sprite2D = $Sprite
@onready var hurtbox_component: HurtboxComponent = $HurtboxComponent
@onready var health_component: HealthComponent = $HealthComponent

func _ready() -> void:
	hurtbox_component.received_damage.connect(damage)
	health_component.died.connect(queue_free)
	linear_velocity.y = 6

func damage():
	sprite.modulate = Color.RED
	await get_tree().create_timer(0.1).timeout
	sprite.modulate = Color.WHITE

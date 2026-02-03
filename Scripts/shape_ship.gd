extends CharacterBody2D


const SPEED = 300.0
@onready var sprite: Sprite2D = $Sprite
@onready var gun: Node2D = $Gun
@onready var hurtbox_component: HurtboxComponent = $HurtboxComponent

func _ready() -> void:
	visible = false
	GameManager.skin_changed.connect(change_space_ship)
	gun.shoot_timer.wait_time = 0.5
	hurtbox_component.received_damage.connect(damage)

func _physics_process(_delta: float) -> void:
	if(GameManager.game_state == GameManager.GameStates.On): visible = true
	else: visible = false
	
	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func damage():
	sprite.modulate = Color.RED
	await get_tree().create_timer(0.1).timeout
	sprite.modulate = Color.WHITE

func change_space_ship(uid : String):
	sprite.set_texture(load(uid))

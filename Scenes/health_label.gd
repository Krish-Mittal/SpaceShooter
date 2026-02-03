extends Label

var hurtbox 
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameManager.game_started.connect(initialize)
	

func initialize():
	hurtbox = %SpaceShip.get_node_or_null("HurtboxComponent")
	if(hurtbox):
		text = "Health : " + str(hurtbox.health.curr_health)
		hurtbox.received_damage.connect(update_health)


func update_health():
	text = "Health : " + str(hurtbox.health.curr_health)

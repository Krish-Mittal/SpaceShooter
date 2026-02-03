class_name HitboxComponent extends Area2D
# Hitbox gives the damage

@export var damage: float = 1: set = set_damage, get = get_damage
@export var team : GameManager.Team

func set_damage(value : float) -> void:
	damage = value

func get_damage() -> float:
	return damage

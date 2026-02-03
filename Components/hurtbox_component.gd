class_name HurtboxComponent extends Area2D

# Hurtbox receives the damage

signal received_damage

@export var health : HealthComponent
@export var team : GameManager.Team

func _ready() -> void:
	connect("area_entered", _on_area_entered)

func _on_area_entered(hitbox: Area2D) -> void:
	if hitbox is HitboxComponent and team != hitbox.team:
		health.damage(hitbox.damage)
		received_damage.emit()

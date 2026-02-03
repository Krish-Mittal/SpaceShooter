extends Control

@onready var sprite: Sprite2D = $Sprite
@onready var main_menu: Control = $"."

func _ready() -> void:
	GameManager.skin_changed.connect(change_space_ship)

func change_space_ship(uid : String):
	sprite.set_texture(load(uid))

func _on_change_skin_button_pressed() -> void:
	GameManager.change_skin()

func _on_play_button_pressed() -> void:
	GameManager.game_state = GameManager.GameStates.On
	GameManager.game_started.emit()
	main_menu.visible = false

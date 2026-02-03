class_name HealthComponent extends Node

#signal max_health_changed(value) 
signal health_changed(value)
signal died

@export var immortality : bool = false : set = set_immortality

@export var max_health:float = 100:
	set(value):
		if(max_health == value): return
		
		max_health = value if(value > 0) else 1.0
		if max_health<curr_health:
			curr_health = max_health
		health_changed.emit(value)

@export var curr_health:float = max_health:
	set(value):
		if(curr_health == value): return
		
		if(value > max_health): curr_health = max_health
		elif(value <= 0): 
			curr_health = 0
			died.emit()
		else: curr_health = value
		
		health_changed.emit(value)

func _ready() -> void:
	curr_health = max_health

func set_immortality(value : bool):
	immortality = value

func set_temp_immortality(time : float):
	var immortality_timer = Timer.new()
	immortality = true
	immortality_timer.one_shot = true
	immortality_timer.wait_time = time
	immortality_timer.timeout.connect(set_immortality(false))
	add_child(immortality_timer)
	immortality_timer.start()

func damage(value : float):
	if immortality: return
	curr_health -= value

func heal(value : float):
	curr_health += value
 

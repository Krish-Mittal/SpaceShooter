extends Node

enum GameStates{
	MainMenu,
	Paused,
	On,
	GameOver
}
enum SpaceShip{
	Blue,
	Red,
	Green
}
signal skin_changed(uid)
signal game_started
var Skins:Dictionary [SpaceShip,String] = {
	SpaceShip.Blue : "uid://cv578cw0s2mc6",
	SpaceShip.Red : "uid://dgvoo7vjq4y6s",
	SpaceShip.Green : "uid://cb1cyircss55y"
}
enum Team{
	Player,
	Enemy
}
var curr_skin := SpaceShip.Blue
var game_state := GameStates.MainMenu 

var score := 0
var mute := false : set = toggle_mute


func reset() -> void:
	curr_skin = SpaceShip.Blue
	game_state = GameStates.MainMenu
	score = 0
	mute = false
func toggle_mute(value:bool):
	if value:
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), -80)
	else:
		AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), 0)

func change_skin():
	curr_skin = (curr_skin+1) % 3
	skin_changed.emit(Skins[curr_skin])

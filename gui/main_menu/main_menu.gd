extends BaseView

@onready var button: Button = $Panel/MarginContainer/VBoxContainer/Button
@onready var button_2: Button = $Panel/MarginContainer/VBoxContainer/Button2
@onready var button_4: Button = $Panel/MarginContainer/VBoxContainer/Button4

var stage_game_data : Dictionary

func _ready() -> void:
	button.pressed.connect(game_start)
	button_2.pressed.connect(game_start)
	button_4.pressed.connect(game_quit)

func set_data_from_main(data:Dictionary) -> void:
	stage_game_data = data

func game_quit() -> void:
	get_tree().quit()

func game_start() -> void:
	base_change_screen_signal.emit("first_game_stage")

	var loaded_game_data : Dictionary = {
		"Res_1": 100000.0, # Azulite
		"Res_2": 10.1, # Vermilite
		"Res_3": 10.2, # Alinte

		"Supply limit": 120,
		"Supply cost": 20,
		"Unit supply consumption": 1.0,
		"Unit supply cost": 50,

		"Worker SPEED": 2.1,
		"Worker SPEED cost": 15,

		"Worker CARGO": 2,
		"Worker CARGO cost": 15,

		"Worker LIMIT": 10,
		"Worker LIMIT cost": 100,
		}
	data_from_stage.emit(loaded_game_data)


func base_show():
	print("this overrides baseshow!")
	super.base_show()

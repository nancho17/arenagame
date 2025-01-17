extends BaseView

@onready var go_arena: Button = $MarginContainer/StoreMenu/MarginContainer/VBoxContainer/GoArena

var stage_game_data : Dictionary

func _ready() -> void:
		go_arena.pressed.connect(go_selected_map.bind(0))

func set_data_from_main(data:Dictionary) -> void:
	stage_game_data = data

func go_selected_map( map_index : int ) -> void:
	#go_selected_map+
	print("selected_map",map_index)
	stage_game_data["selected_map"] = map_index
	data_from_stage.emit(stage_game_data)
	base_change_screen_signal.emit("second_game_stage")

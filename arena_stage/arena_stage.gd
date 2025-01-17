extends BaseView

var stage_game_data : Dictionary

func set_data_from_main(data:Dictionary) -> void:
	stage_game_data = data

func back_to_store(current_data:Dictionary):
	data_from_stage.emit(current_data)
	base_change_screen_signal.emit("first_game_stage")

func end_of_supply_back() -> void:
	print("end_of_supply_back",end_of_supply_back)

extends Node
var root = null
var current_screen 
var current_screen_node : BaseView
var is_changing_screen := false

const MENU_SCENE = preload("res://gui/main_menu/main_menu.tscn")
const LOBBY_STAGE = preload("res://lobby_stage/lobby_stage.tscn")
const ARENA_STAGE = preload("res://arena_stage/arena_stage.tscn")

const MAIN_SEPARATOR : StringName = &" "
const DECIMAL_SEPARATOR : StringName = &","

var game_data :Dictionary

##Data structure
var player_pawn : Node3D
var pawn_1_1 : Node3D
var player_pawn_2 : Node3D
var player_pawn_3 : Node3D

#GAME SCREENS
@onready var screen_scenes := {
	"main_menu": MENU_SCENE,
	"first_game_stage": LOBBY_STAGE,
	"second_game_stage": ARENA_STAGE,
	}

func _ready():
	root = self
	var new_screen_node  = screen_scenes["main_menu"].instantiate()
	await add_new_screen(new_screen_node, "main_menu")
	is_changing_screen = false

func change_screen(new_screen: String) -> void:
	if is_changing_screen:
		return
	is_changing_screen = true
	var new_screen_node  = screen_scenes[new_screen].instantiate()
	load_new_screen(new_screen_node, new_screen)
	is_changing_screen = false


func hide_old_screen(new_screen_node, new_screen: String) -> void:
#	current_screen_node.call_deferred("prepare_to_hide")
#	await current_screen_node.did_prepare_to_hide
	
	current_screen_node.base_hide.call_deferred()
	await current_screen_node.did_hide

	current_screen_node.queue_free()

	new_screen_node.call_deferred("prepare_to_show")
	await new_screen_node.did_prepare_to_show

func add_new_screen(new_screen_node, new_screen: String) -> void:
	root.add_child(new_screen_node)
	new_screen_node.base_change_screen_signal.connect(change_screen)
	new_screen_node.base_show.call_deferred()
	await new_screen_node.did_show
	
	current_screen = new_screen
	current_screen_node = new_screen_node
	current_screen_node.data_from_stage.connect(save_data_from_stage)
	current_screen_node.get_data_from_main.connect(set_data_to_stage)
	set_data_to_stage()

func load_new_screen(new_screen_node, new_screen: String) -> void:
	hide_old_screen(new_screen_node,new_screen)
	add_new_screen(new_screen_node,new_screen)

func set_data_to_stage() -> void:
	current_screen_node.set_data_from_main(game_data) 

func save_data_from_stage(data: Dictionary) -> void:
	game_data = data

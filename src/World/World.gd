extends Node2D
class_name GameWorld


signal game_over

var world_map : WorldMap
var adventurer_scene
var adventurers_collection : Node
var turn_timer : Timer

func _ready():
	world_map = get_node("WorldMap")
	turn_timer = get_node("TurnTimer")
	adventurers_collection = get_node("AdventurersCollection")
	
func _process(delta):
	pass

func spawn_adventurer(var pos: Vector2 ):
	if adventurer_scene == null:
		adventurer_scene = load("res://src/Adventurers/Adventurers.tscn")
	var adventurer = adventurer_scene.instance()
	adventurer.pos = pos
	adventurer.last_pos = pos

	adventurer.unexplored = get_node("WorldMap").full_exploration_set.duplicate()
	# Get node because spawn_adventurer can be called before _ready
	get_node("AdventurersCollection").call_deferred("add_child", adventurer)

func begin():
	turn_timer.start()
	world_map.enable_placement()
	
func game_over():
	turn_timer.stop()
	world_map.disable_placement()
	emit_signal("game_over")

func _on_BuildMenu_build_mode_set(tile: int):
	world_map.build_mode = tile

func _on_BeginGame_pressed():
	begin()

extends Node2D
class_name GameWorld

var world_map : WorldMap
var adventurer_scene

func _ready():
	world_map = get_node("WorldMap")
	print("HEllo, World")
	print(world_map.world_tile_map.map_to_world(Vector2(3, -1)))
func _process(delta):
	pass
func spawn_adventurer(var pos: Vector2 ):
	if adventurer_scene == null:
		adventurer_scene = load("res://src/Adventurers/Adventurers.tscn")
	var adventurer = adventurer_scene.instance()
	adventurer.Pos = pos
	call_deferred("add_child",adventurer)

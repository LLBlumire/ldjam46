extends Node2D
class_name GameWorld

var world_map : WorldMap
var adventurer_scene

func _ready():
	world_map = get_node("WorldMap")
	print("HEllo, World")
	print(world_map.world_tile_map.map_to_world(Vector2(3, -1)))
	adventurer_scene = load("res://src/Adventurers/Adventurers.tscn")
	spawn_adventurer(Vector2(0,0))
func _process(delta):
	pass
func spawn_adventurer(var pos: Vector2 ):
	var adventurer = adventurer_scene.instance()
	adventurer.Pos = pos
	add_child(adventurer)

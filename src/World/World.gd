extends Node2D
class_name GameWorld

var world_map : WorldMap

func _ready():
	world_map = get_node("WorldMap")
	print("HEllo, World")
	print(world_map.world_tile_map.map_to_world(Vector2(3, -1)))
func _process(delta):
	pass

extends Node2D

var world_cursor: WorldEdit
var world_tile_map: TileMap

func _ready():
	world_cursor = get_tree().get_root().get_node("World/WorldMap/WorldSelect")
	world_tile_map = get_tree().get_root().get_node("World/WorldMap/WorldTileMap")
	print("HEllo, World")
	print(world_tile_map.map_to_world(Vector2(3, -1)))
func _process(delta):
	pass

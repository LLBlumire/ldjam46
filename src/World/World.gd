extends Node2D

var world_cursor: WorldEdit
var world_tile_map: TileMap

func _ready():
	world_cursor = get_tree().get_root().get_node("World/WorldMap/WorldSelect")
	world_tile_map = get_tree().get_root().get_node("World/WorldMap/WorldTileMap")

func _process(delta):
	pass

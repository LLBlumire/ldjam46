extends Node2D
class_name WorldMap

signal tile_clicked

const SELECTED: int = 0

var cursor: Vector2
var building_popup : PopupMenu
var world_tile_map : TileMap
var world_select : TileMap

# Called when the node enters the scene tree for the first time.
func _ready():
	cursor = Vector2(0, 0)
	world_tile_map = get_node("WorldTileMap")
	world_select = get_node("WorldSelect")
	
func map_to_world(vec : Vector2):
	return world_select.map_to_world(vec)
	
func _input(event):
	# Mouse in viewport coordinates
	if event is InputEventMouseButton:
		emit_signal("tile_clicked", cursor)

func _process(delta):
	clear_cursor()
	cursor = world_select.world_to_map(get_global_mouse_position())
	place_cursor()
	
func place_cursor():
	world_select.set_cellv(cursor, 0)
	
func clear_cursor():
	world_select.set_cellv(cursor, -1)

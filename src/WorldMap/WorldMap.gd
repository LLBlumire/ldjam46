extends Node2D
class_name WorldMap

signal tile_clicked

const SELECTED: int = 0

var mouse_cursor: Vector2
var click_cursor: Vector2
var building_popup : PopupMenu
var world_tile_map : TileMap
var world_select : TileMap
var neighbour_mask : TileMap

# Called when the node enters the scene tree for the first time.
func _ready():
	mouse_cursor = Vector2(0, 0)
	world_tile_map = get_node("WorldTileMap")
	world_select = get_node("WorldSelect")
	neighbour_mask = get_node("NeighbourMask")
	place_tile(Vector2(0, 0), 0)
	
func map_to_world(vec : Vector2):
	return world_select.map_to_world(vec)

func _process(delta):
	clear_cursor()
	mouse_cursor = world_select.world_to_map(get_global_mouse_position())
	if neighbour_mask.get_cellv(mouse_cursor) == 0:
		if world_tile_map.get_cellv(mouse_cursor) == -1:
			place_cursor()
			if Input.is_action_just_pressed("ui_select"):
				click_cursor = mouse_cursor
				emit_signal("tile_clicked", click_cursor)
				print(click_cursor)
	
func place_cursor():
	world_select.set_cellv(mouse_cursor, 0)
	
func clear_cursor():
	world_select.set_cellv(mouse_cursor, -1)

func place_tile(location: Vector2, tile: int):
	world_select.set_cellv(location, tile)
	neighbour_mask.set_cellv(location, 0)
	neighbour_mask.set_cellv(location + Vector2(0, 1), 0)
	neighbour_mask.set_cellv(location + Vector2(0, -1), 0)
	neighbour_mask.set_cellv(location + Vector2(1, 0), 0)
	neighbour_mask.set_cellv(location + Vector2(-1, 0), 0)

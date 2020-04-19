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
var world_node : Node2D
var building_scene
var building_flag : bool = false
var lower_bounds : Vector2 = Vector2(0, 0)
var upper_bounds : Vector2 = Vector2(0, 0)

# Called when the node enters the scene tree for the first time.
func _ready():
	mouse_cursor = Vector2(0, 0)
	world_tile_map = get_node("WorldTileMap")
	world_select = get_node("WorldSelect")
	neighbour_mask = get_node("NeighbourMask")
	world_node = get_tree().get_root().get_node("World")
	place_tile(Vector2(0, 0), 0)
	building_scene = load("res://src/UI/BuildingMenu.tscn")
	
func map_to_world(vec : Vector2):
	return world_select.map_to_world(vec)

func _process(delta):
	clear_cursor()
	mouse_cursor = world_select.world_to_map(get_global_mouse_position())
	if neighbour_mask.get_cellv(mouse_cursor) == 0:
		if world_tile_map.get_cellv(mouse_cursor) == -1:
			place_cursor()
			if Input.is_action_just_pressed("ui_select"):
				if building_flag == false:
					print(click_cursor)
					click_cursor = mouse_cursor
					emit_signal("tile_clicked", click_cursor)
					building_flag = true
					var building_menu = building_scene.instance()
					building_menu.position = world_tile_map.map_to_world(click_cursor)
					building_menu.click_cursor = click_cursor
					add_child(building_menu)
func place_cursor():
	world_select.set_cellv(mouse_cursor, 0)
	
func clear_cursor():
	world_select.set_cellv(mouse_cursor, -1)

func place_tile(location: Vector2, tile: int):
	world_tile_map.set_cell(location.x, location.y, 0, false, false, false, Vector2(tile, 0))
	if tile == 0:
		world_node.spawn_adventurer(location)
	neighbour_mask.set_cellv(location, 0)
	neighbour_mask.set_cellv(location + Vector2(0, 1), 0)
	neighbour_mask.set_cellv(location + Vector2(0, -1), 0)
	neighbour_mask.set_cellv(location + Vector2(1, 0), 0)
	neighbour_mask.set_cellv(location + Vector2(-1, 0), 0)
	var world_loc = map_to_world(location)
	if world_loc.x < lower_bounds.x:
		lower_bounds.x = world_loc.x
	if world_loc.y < lower_bounds.y:
		lower_bounds.y = world_loc.y
	if world_loc.x > upper_bounds.x:
		upper_bounds.x = world_loc.x
	if world_loc.y > upper_bounds.y:
		lower_bounds.y = world_loc.y

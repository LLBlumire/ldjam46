extends Node2D
class_name WorldMap

signal tile_added

var mouse_cursor: Vector2
var click_cursor: Vector2
var world_tile_map : TileMap
var world_select : TileMap
var neighbour_mask : TileMap
var world_node : Node2D
var lower_bounds : Vector2 = Vector2(0, 0)
var upper_bounds : Vector2 = Vector2(0, 0)
var tile_data : Dictionary = {}
var build_mode : int
var place : AudioStreamPlayer2D
var astar : AStar2D = AStar2D.new()
var pos_ids : Dictionary = {}
var towns : PoolIntArray = PoolIntArray([])
var level : Dictionary = {}
var full_exploration_set : Dictionary = {}
var placement_enabled : bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	mouse_cursor = Vector2(0, 0)
	world_tile_map = get_node("WorldTileMap")
	world_select = get_node("WorldSelect")
	neighbour_mask = get_node("NeighbourMask")
	place = get_node(NodeMgr.audio_place)
	world_node = get_node(NodeMgr.world)
	place_tile(Vector2(0, 0), 0, false)
	build_mode = 0
	
func map_to_world(vec : Vector2):
	return world_select.map_to_world(vec)

func enable_placement():
	placement_enabled = true
	
func disable_placement():
	placement_enabled = false

func _process(delta):
	clear_cursor()
	# This is a hack for nested viewports, see https://github.com/godotengine/godot/issues/32222
	var zoom = get_node(NodeMgr.camera).zoom
	var offset_position = get_tree().current_scene.get_global_mouse_position() - get_viewport_transform().origin
	offset_position *= zoom
	mouse_cursor = world_select.world_to_map(offset_position)
	# END HACK
	if neighbour_mask.get_cellv(mouse_cursor) == 0:
		if world_tile_map.get_cellv(mouse_cursor) == -1:
			place_cursor()
			if Input.is_action_just_pressed("ui_select") && placement_enabled:
				place_tile(mouse_cursor, build_mode)

func place_cursor():
	world_select.set_cell(mouse_cursor.x, mouse_cursor.y, 0, false, false, false, Vector2(build_mode, 0))
	
func clear_cursor():
	world_select.set_cellv(mouse_cursor, -1)

func place_tile(location: Vector2, tile: int, make_noise: bool = true):
	world_tile_map.set_cell(location.x, location.y, 0, false, false, false, Vector2(tile, 0))
	tile_data[location] = get_tile_name(tile)
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
		upper_bounds.y = world_loc.y
	if make_noise:
		place.play()
	if tile == TileData.OCEAN:
		return
	var this_astar_id = astar.get_available_point_id()
	astar.add_point(this_astar_id, location)
	pos_ids[location] = this_astar_id
	if pos_ids.has(location + Vector2(1, 0)):
		astar.connect_points(this_astar_id, pos_ids[location + Vector2(1, 0)])
	if pos_ids.has(location + Vector2(-1, 0)):
		astar.connect_points(this_astar_id, pos_ids[location + Vector2(-1, 0)])
	if pos_ids.has(location + Vector2(0, 1)):
		astar.connect_points(this_astar_id, pos_ids[location + Vector2(0, 1)])
	if pos_ids.has(location + Vector2(0, -1)):
		astar.connect_points(this_astar_id, pos_ids[location + Vector2(0, -1)])
	if tile == 0:
		world_node.spawn_adventurer(location)
		towns.append(this_astar_id)
	level[this_astar_id] = TileData.LEVELS[tile]
	full_exploration_set[this_astar_id] = true
	emit_signal("tile_added", this_astar_id)
		
func get_tile_name(tile: int):
	if tile == TileData.ARCTIC:
		return "The Cold"
	if tile == TileData.ALPINE:
		tile = TileData.MOUNTAIN
	if tile == TileData.CAVES:
		tile = TileData.MOUNTAIN
	if tile == TileData.OCEAN:
		return "The Ocean"
	return TileData.NAMES[tile][randi() % TileData.NAMES.size()]

func get_tile_difficulty(pos: Vector2):
	var tile = world_tile_map.get_cell_autotile_coord(pos.x, pos.y).x
	return TileData.LEVELS[tile]

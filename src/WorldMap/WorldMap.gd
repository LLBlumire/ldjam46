extends Node2D
class_name WorldMap

signal tile_added

var mouse_cursor: Vector2
var click_cursor: Vector2
var world_tile_map : TileMap
var world_select : TileMap
var neighbour_mask : TileMap
var world_borders : TileMap
var world_node : Node2D
var lower_bounds : Vector2 = Vector2(0, 0)
var upper_bounds : Vector2 = Vector2(0, 0)
var tile_data : Dictionary = {}
var build_mode : int
var place : AudioStreamPlayer
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
	world_borders = get_node("WorldBorderMap")
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
	get_node(NodeMgr.chat_log).post_message("{place} is now explorable!".format({"place":tile_data[location]}))
	if tile == 0:
		world_node.spawn_adventurer(location)
		towns.append(this_astar_id)
	level[this_astar_id] = TileData.LEVELS[tile]
	full_exploration_set[this_astar_id] = true
	place_borders(location)
	emit_signal("tile_added", this_astar_id)
	
func place_borders(location: Vector2):
	var north = Vector2(0, -1)
	var east = Vector2(1, 0)
	var south = Vector2(0, 1)
	var west = Vector2(-1, 0)
	var loc_north = location + north
	var loc_north_east = location + north + east
	var loc_east = location + east
	var loc_south_east = location + south + east
	var loc_south = location + south
	var loc_south_west = location + south + west
	var loc_west = location + west
	var loc_north_west = location + north + west
	var exists = {}
	exists[north] = world_borders.get_cellv(loc_north) != -1
	exists[north+east] = world_borders.get_cellv(loc_north_east) != -1
	exists[east] = world_borders.get_cellv(loc_east) != -1
	exists[south+east] = world_borders.get_cellv(loc_south_east) != -1
	exists[south] = world_borders.get_cellv(loc_south) != -1
	exists[south+west] = world_borders.get_cellv(loc_south_west) != -1
	exists[west] = world_borders.get_cellv(loc_west) != -1
	exists[north+west] = world_borders.get_cellv(loc_north_west) != -1
	var offsets = {}
	offsets[north] = from_ternary(world_borders.get_cell_autotile_coord(loc_north.x, loc_north.y).x)
	offsets[north+east] = from_ternary(world_borders.get_cell_autotile_coord(loc_north_east.x, loc_north_east.y).x)
	offsets[east] = from_ternary(world_borders.get_cell_autotile_coord(loc_east.x, loc_east.y).x)
	offsets[south+east] = from_ternary(world_borders.get_cell_autotile_coord(loc_south_east.x, loc_south_east.y).x)
	offsets[south] = from_ternary(world_borders.get_cell_autotile_coord(loc_south.x, loc_south.y).x)
	offsets[south+west] = from_ternary(world_borders.get_cell_autotile_coord(loc_south_west.x, loc_south_west.y).x)
	offsets[west] = from_ternary(world_borders.get_cell_autotile_coord(loc_west.x, loc_west.y).x)
	offsets[north+west] = from_ternary(world_borders.get_cell_autotile_coord(loc_north_west.x, loc_north_west.y).x)
	if !exists[north]: offsets[north] = [0,0,0,0]
	if !exists[north+east]: offsets[north+east] = [0,0,0,0]
	if !exists[east]: offsets[east] = [0,0,0,0]
	if !exists[south+east]: offsets[south+east] = [0,0,0,0]
	if !exists[south]: offsets[south] = [0,0,0,0]
	if !exists[south+west]: offsets[south+west] = [0,0,0,0]
	if !exists[west]: offsets[west] = [0,0,0,0]
	if !exists[north+west]: offsets[north+west] = [0,0,0,0]
	
	offsets[north][3] = 2
	offsets[north+east][3] = max(1, offsets[north+east][3])
	offsets[east][2] = 2
	offsets[south+east][2] = max(1, offsets[south+east][2])
	offsets[south][1] = 2
	offsets[south+west][1] = max(1, offsets[south+west][1])
	offsets[west][0] = 2
	offsets[north+west][0] = max(1, offsets[north+west][0])
	
#	set_border(loc_north, to_ternary(offsets[north]))
#	set_border(loc_north_east, to_ternary(offsets[north+east]))
#	set_border(loc_east, to_ternary(offsets[east]))
#	set_border(loc_south_east, to_ternary(offsets[south+east]))
#	set_border(loc_south, to_ternary(offsets[south]))
#	set_border(loc_south_west, to_ternary(offsets[south+west]))
#	set_border(loc_west, to_ternary(offsets[west]))
#	set_border(loc_north_west, to_ternary(offsets[north+west]))
	
func from_ternary(num: int):
	num = num + 1
	var zero = num % 3
	var one = (num / 3) % 3
	var two = (num / 9) % 3
	var three = (num / 27) % 3
	return [zero, one, two, three]

func to_ternary(num: Array):
	return num[0] + (num[1]*3) + (num[2]*3*3) + (num[3]*3*3*3) - 1

func set_border(loc, tile):
	world_borders.set_cell(loc.x, loc.y, 0, false, false, false, Vector2(tile, 0))

func get_tile_name(tile: int):
	if tile == TileData.ARCTIC:
		return "The Cold"
	if tile == TileData.ALPINE:
		tile = TileData.MOUNTAIN
	if tile == TileData.CAVES:
		tile = TileData.MOUNTAIN
	return TileData.NAMES[tile][randi() % TileData.NAMES[tile].size()]

func get_tile_difficulty(pos: Vector2):
	var tile = world_tile_map.get_cell_autotile_coord(pos.x, pos.y).x
	return TileData.LEVELS[tile]

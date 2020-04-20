extends Node2D
class_name Adventurer

signal game_over

var health_bar : TextureProgress
var satisfaction_bar : TextureProgress
var level_bar : TextureProgress
var world_node
var world_map
var satisfaction_timer : Timer
var exploration_timer : Timer
var turn_timer : Timer
var visited_map : TileMap
var skeleton : Sprite
var costume : Sprite
var hair : Sprite
enum {Thief, Wizard, Fighter, Halfling, Elf, Gnome}
var race : int = 0

var level : int = 1
var adventure_count : int = 0
var next_level : int = 10
var adventurer_name : String = ""
var race_string : String = ""
var current_health : float = 0.0
var current_satisfaction : float = 0.0
var strength : float = 0.0
var dexterity : float = 0.0
var intelligence : float = 0.0
var sex : int = 0
var hair_val : int = 0
var mediocre : bool = false
var pos : Vector2 = Vector2(0,0)
var last_pos : Vector2 = Vector2(0,0)
var pos_progress : float = 1.0
var rng = RandomNumberGenerator.new()
var ready_to_adventure = true

var unexplored : Dictionary = {}

func _ready():
	health_bar = get_node("BarsContainer/HP")
	satisfaction_bar = get_node("BarsContainer/SP")
	level_bar = get_node("BarsContainer/Level")
	skeleton = get_node("AdventurerSkeleton")
	costume = get_node("AdventurerCostume")
	hair = get_node("AdventurerHair")
	world_node = get_node(NodeMgr.world)
	world_map = world_node.world_map
	turn_timer = world_node.turn_timer
	turn_timer.connect("timeout",self,"_on_TurnTimer_timeout")
	world_map.connect("tile_added",self,"_on_WorldMap_tile_added")
	rng.randomize()
	current_health = 1
	current_satisfaction = 1
	sex = bool(rng.randi_range(0,1)) # 0 = male, 1 = female
	strength = gen_stat()
	dexterity = gen_stat()
	intelligence = gen_stat()
	hair_val = rng.randi_range(0,7)
	set_race()
	set_adventurer_name()
	set_sprite()
	update_stats()
	get_node(NodeMgr.chat_log).post_message("{name} the {class} has pledged themselves to the duty of adventure!".format({"name":adventurer_name,"class": race_string}))
	var cpos = world_node.world_map.map_to_world(pos) + Vector2(16,10)
	position = cpos
	scale = Vector2(0.8, 0.8)

func gen_stat() -> float:
	return rng.randi_range(1, 6) + \
		rng.randi_range(1, 6) + \
		rng.randi_range(1, 6) as float

func update_stats():
	health_bar.value = current_health
	satisfaction_bar.value = current_satisfaction
	level_bar.value = level
	if current_health <= 0 :
		death()
	if current_satisfaction <= 0:
		boredom()

func move_to(var position : Vector2):
	pos_progress = 0.0
	last_pos = pos
	pos = position
	ready_to_adventure = true

func death():
	get_node(NodeMgr.chat_log).post_message("[color=red]{name} horribly died in {place}![/color]".format({"name":adventurer_name,"place":world_map.tile_data[pos]}))
	world_node.game_over()

func boredom():
	get_node(NodeMgr.chat_log).post_message("[color=red]{name} got really bored in {place} and quit adventuring![/color]".format({"name":adventurer_name,"place":world_map.tile_data[pos]}))
	world_node.game_over()

func set_sprite():
	var skel = 0
	var cost = 0
	var issmall = race >= 4
	skel = max(0, race - 2)
	cost = 2 * race
	skeleton.texture.region = Rect2(skel * 24,0,24,32)
	costume.texture.region = Rect2((cost + sex) * 24, 0,24,32)
	hair.texture.region = Rect2((hair_val*4+sex*2+int(issmall))*24, 0, 24, 32)

func set_race():
	var fighter = strength >= 13
	var wizard = intelligence >= 13
	var rogue = dexterity >= 13
	var elf = fighter && wizard
	var halfling = fighter && rogue
	var gnome = wizard && rogue
	if elf:
		race = Elf
		race_string = "Elf"
	elif halfling:
		race = Halfling
		race_string = "Halfling"
	elif gnome:
		race = Gnome
		race_string = "Gnome"
	elif fighter:
		race = Fighter
		race_string = "Fighter"
	elif wizard:
		race = Wizard
		race_string = "Wizard"
	elif rogue:
		race = Thief
		race_string = "Thief"
	else:
		race = rng.randi_range(Thief,Gnome)
		race_string = "Mediocre"
		mediocre = true

func set_adventurer_name():
	var file : File = File.new()
	var rs = rng.randi_range(0,99)
	var first_name : String
	var last_name : String
	if race <= Fighter: #Human
		var rf = rng.randi_range(0,79)
		
		if sex == 0:
			file.open("res://res/Adventurers/Names/HumanM.txt",File.READ)
		elif sex == 1:
			file.open("res://res/Adventurers/Names/HumanF.txt",File.READ)
		for i in range(rf):
			first_name = file.get_line()
		
	elif race == Elf :
		var rf = rng.randi_range(0,49)
		
		if sex == 0:
			file.open("res://res/Adventurers/Names/ElfM.txt",File.READ)
		elif sex == 1:
			file.open("res://res/Adventurers/Names/ElfF.txt",File.READ)
		for i in range(rf):
			first_name = file.get_line()
	
	elif race == Gnome :
		var rf = rng.randi_range(0,49)
		
		if sex == 0:
			file.open("res://res/Adventurers/Names/GnomeM.txt",File.READ)
		elif sex == 1:
			file.open("res://res/Adventurers/Names/GnomeF.txt",File.READ)
		for i in range(rf):
			first_name = file.get_line()
	
	elif race == Halfling :
		var rf = rng.randi_range(0,49)
		
		if sex == 0:
			file.open("res://res/Adventurers/Names/HalflingM.txt",File.READ)
		elif sex == 1:
			file.open("res://res/Adventurers/Names/HalflingF.txt",File.READ)
		for i in range(rf):
			first_name = file.get_line()
	file.close()
	file.open("res://res/Adventurers/Names/Lastnames.txt", File.READ)
	for i in range(rs):
		last_name = file.get_line()
	
	adventurer_name = first_name + " " + last_name

func _process(delta):
	var lpos = world_node.world_map.map_to_world(last_pos) + Vector2(16,10)
	var cpos = world_node.world_map.map_to_world(pos) + Vector2(16,10)
	position = lerp(lpos, cpos, pos_progress)
	pos_progress = clamp(pos_progress + (delta), 0, 1)
	scale = Vector2(0.8, 0.8)
	if ready_to_adventure && pos_progress == 1:
		ready_to_adventure = false
		have_adventure(world_map.world_tile_map.get_cell_autotile_coord(pos.x, pos.y).x)
	
func have_adventure(var terrain : int):
	var terrain_level = TileData.LEVELS[terrain]
	var action = "bored"
	var quot : float = float(terrain_level) / float(level)
	current_satisfaction = clamp(current_satisfaction - 0.1, 0, 1)
	if unexplored.has(world_map.pos_ids[pos]):
		current_satisfaction = clamp(current_satisfaction + (0.2 * quot), 0, 1)
		unexplored.erase(world_map.pos_ids[pos])
		action = "adventuring"
	if terrain == 0:
		current_health = clamp(current_health + 0.5, 0, 1)
		action = "resting"
	else:
		current_health = clamp(current_health - (0.1*quot), 0, 1)
	adventure_count += 1
	if adventure_count >= next_level && level < 5:
		next_level *= 2
		level += 1
	update_stats()
	get_node(NodeMgr.chat_log).post_message("{name} is {action} in {place}.".format({"name":adventurer_name,"place":world_map.tile_data[pos],"action" : action }))
	
func _on_TurnTimer_timeout():
	if world_map.world_tile_map.get_cell_autotile_coord(pos.x, pos.y).x == 0 && current_health < 1: #is on town
		current_health = min(current_health + 0.5, 1)
	elif current_health <= 0.3:
		get_node(NodeMgr.chat_log).post_message("{name} is badly wounded and looking for shelter.".format({"name":adventurer_name}))
		var here_id = world_map.pos_ids[pos]
		var shortest_path = []
		var shortest_path_size = 9223372036854775807
		for town_id in world_map.towns:
			var path = world_map.astar.get_id_path(here_id, town_id)
			if path.size() < shortest_path_size:
				shortest_path = path
				shortest_path_size = path.size()
		if shortest_path_size > 1:
			move_to(world_map.astar.get_point_position(shortest_path[1]))
		else:
			move_to(pos)
	else:
		var here_id = world_map.pos_ids[pos]
		var shortest_path = []
		var shortest_path_size = 9223372036854775807
		for unex_id in unexplored:
			var wlevel = world_map.level[unex_id]
			if (level - wlevel) > 1 || (level - wlevel) < -1:
				continue
			var path = world_map.astar.get_id_path(here_id, unex_id)
			if path.size() < shortest_path_size:
				shortest_path = path
				shortest_path_size = path.size()
		if shortest_path_size == 9223372036854775807:
			move_to(pos)
		elif shortest_path_size > 1:
			move_to(world_map.astar.get_point_position(shortest_path[1]))
		else:
			move_to(pos)

func _on_WorldMap_tile_added(astar_id):
	unexplored[astar_id] = true

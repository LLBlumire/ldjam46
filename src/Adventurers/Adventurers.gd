extends Node2D
class_name Adventurer

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var Healthbar : Label
var satisfaction_bar : Label
var world_node : GameWorld
var world_map : WorldMap
var satisfaction_timer : Timer
var exploration_timer : Timer
var turn_timer : Timer
var visited_map : TileMap

var skeleton : Sprite
var costume : Sprite
var hair : Sprite
enum {Thief, Wizard, Fighter, Halfling, Elf, Gnome}
var race : int = 0

var AdventurerName : String = ""
var Health : float = 0.0 
var CurrentHealth : float = 0.0
var Satisfaction : float = 0.0
var current_satisfaction : float = 0.0
var Strenght : float = 0.0
var Dexterity : float = 0.0
var Intelligence : float = 0.0
var Sex : int = 0
var Hair : int = 0
var Mediocre : bool = false
var Pos : Vector2 = Vector2(0,0)
var rng = RandomNumberGenerator.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	Healthbar =get_node("VBoxContainer/HealthBar")
	satisfaction_bar = get_node("VBoxContainer/SatisfactionBar")
	satisfaction_timer = get_node("SatisfactionDecay")
	exploration_timer = get_node("ExplorationTimer")
	visited_map = get_node("VisitedMap")
	skeleton = get_node("AdventurerSkeleton")
	costume = get_node("AdventurerCostume")
	hair = get_node("AdventurerHair")
	world_node = get_node("..")
	world_map = world_node.world_map
	turn_timer = world_node.turn_timer
	turn_timer.connect("timeout",self,"_on_TurnTimer_timeout")
	rng.randomize()
	Health = 1
	CurrentHealth = 0.1
	Satisfaction = 1
	current_satisfaction = Satisfaction
	Sex = rng.randi_range(0,1) # 0 = male, 1 = female
	Strenght = gen_stat()
	Dexterity = gen_stat()
	Intelligence = gen_stat()
	Hair = rng.randi_range(0,7)
	set_race()
	set_adventurer_name()
	set_sprite()
	update_stats()
	update_pos()



func gen_stat() -> float:
	return rng.randi_range(1, 6) + rng.randi_range(1, 6) + rng.randi_range(1, 6) as float

func update_stats():
	Healthbar.set_text("HP:{current}/{max}".format({"current": CurrentHealth, "max": Health}))
	satisfaction_bar.set_text("SP:{current}/{max}".format({"current": current_satisfaction, "max": Satisfaction}))
	if CurrentHealth < 0 :
		death()
	if current_satisfaction < 0:
		boredom()

func update_pos():
	position = world_node.world_map.map_to_world(Pos) + Vector2(16,16)
	

func move_to(var Position : Vector2):
	Pos = Position
	visited_map.set_cellv(Position,1)
	update_pos()
	

func death():
	get_parent().remove_child(self)
	print("F")

func boredom():
	get_parent().remove_child(self)
	print("BOOOOOORING")

func set_sprite():
	var skel = 0
	var cost = 0
	var issmall = race >= 4
	skel = max(0, race - 2)
	cost = 2 * race
	skeleton.texture.region = Rect2(skel * 24,0,24,32)
	costume.texture.region = Rect2((cost + Sex) * 24, 0,24,32)
	hair.texture.region = Rect2((Hair*4+Sex*2+int(issmall))*24, 0, 24, 32)

func set_race():
	var fighter = Strenght >= 13
	var wizard = Intelligence >= 13
	var rogue = Dexterity >= 13
	var elf = fighter && wizard
	var halfling = fighter && rogue
	var gnome = wizard && rogue
	if elf:
		race = Elf
	elif halfling:
		race = Halfling
	elif gnome:
		race = Gnome
	elif fighter:
		race = Fighter
	elif wizard:
		race = Wizard
	elif rogue:
		race = Thief
	else:
		race = rng.randi_range(Thief,Gnome)
		Mediocre = true

func set_adventurer_name():
	var file : File = File.new()
	var rs = rng.randi_range(0,99)
	var first_name : String
	var last_name : String
	if race <= Fighter: #Human
		var rf = rng.randi_range(0,79)
		
		if Sex == 0:
			file.open("res://res/Adventurers/Names/HumanM.txt",File.READ)
		elif Sex == 1:
			file.open("res://res/Adventurers/Names/HumanF.txt",File.READ)
		for i in range(rf):
			first_name = file.get_line()
		
	elif race == Elf :
		var rf = rng.randi_range(0,49)
		
		if Sex == 0:
			file.open("res://res/Adventurers/Names/ElfM.txt",File.READ)
		elif Sex == 1:
			file.open("res://res/Adventurers/Names/ElfF.txt",File.READ)
		for i in range(rf):
			first_name = file.get_line()
	
	elif race == Gnome :
		var rf = rng.randi_range(0,49)
		
		if Sex == 0:
			file.open("res://res/Adventurers/Names/GnomeM.txt",File.READ)
		elif Sex == 1:
			file.open("res://res/Adventurers/Names/GnomeF.txt",File.READ)
		for i in range(rf):
			first_name = file.get_line()
	
	elif race == Halfling :
		var rf = rng.randi_range(0,49)
		
		if Sex == 0:
			file.open("res://res/Adventurers/Names/HalflingM.txt",File.READ)
		elif Sex == 1:
			file.open("res://res/Adventurers/Names/HalflingF.txt",File.READ)
		for i in range(rf):
			first_name = file.get_line()
	file.close()
	file.open("res://res/Adventurers/Names/Lastnames.txt",File.READ)
	for i in range(rs):
		last_name = file.get_line()
	
	AdventurerName = first_name + " " + last_name

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):

func have_adventure(var terrain : int):
	visited_map.set_cellv(Pos,1)
	CurrentHealth -= 0.1
	current_satisfaction += 0.1

func _on_TurnTimer_timeout():
	if visited_map.get_cellv(Pos) == -1:
		have_adventure(world_map.world_tile_map.get_cellv(Pos))
		return
	elif world_map.world_tile_map.get_cellv(Pos) == 0 && CurrentHealth < Health: #is on town
		CurrentHealth = min(CurrentHealth + 0.5,Health)
		return
	elif CurrentHealth <= 0.2 :
		var town = find_closest_town()
		var direction = town - Pos
		if direction.x != 0:
			move_to(Pos + Vector2(sign(direction.x),0))
		elif direction.y != 0:
			move_to(Pos + Vector2(0, sign(direction.y)))
		pass #find and move towards closest unexplored tile
	

func find_closest_town(): 
	var Queue : Array = []
	var visited : Array = []
	var current : Vector2
	Queue.push_back(Pos)
	visited.push_back(Pos)
	while Queue.empty() == false:
		current = Queue.pop_front()
		if world_map.world_tile_map.get_cellv(current) == 0: #is town
			return current
			
		var dir = [current + Vector2(1,0),
		current + Vector2(0,1),
		current + Vector2(-1,0),
		current + Vector2(0,-1)]
		for i in dir:
			if !visited.has(i):
				visited.push_back(i)
				Queue.push_back(i)
	

#func _on_SatisfactionDecay_timeout():
#	current_satisfaction -= 1
#	update_stats()
#
#
#func _on_ExplorationTimer_timeout():
#	var random = rng.randi_range(1,4)
#	if random == 1: #move east
#		Pos = Pos + Vector2(1,0)
#	elif random == 2: #move south
#		Pos = Pos + Vector2(0,1)
#	elif random == 3: #move west
#		Pos = Pos + Vector2(-1,0)
#	elif random == 4: #move north
#		Pos = Pos + Vector2(0,-1)
#	update_pos()
#	if world_map.world_tile_map.get_cellv(Pos) == -1:
#		current_satisfaction -= 10
#		update_stats()
#	else :
#		have_adventure(world_map.world_tile_map.get_cellv(Pos))

extends Node2D
class_name Adventurer

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var Healthbar : Label
var satisfaction_bar : Label
var Worldnode : Node2D
var world_map : Node2D

var Health : float = 0.0 
var CurrentHealth : float = 0.0
var Satisfaction : float = 0.0
var current_satisfaction : float = 0.0
var Strenght : float = 0.0
var Dexterity : float = 0.0
var Intelligence : float = 0.0
var Pos : Vector2 = Vector2(0,0)
var rng = RandomNumberGenerator.new()
# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	Health = 20 + gen_stat()
	CurrentHealth = Health
	Satisfaction = 20 + gen_stat()
	current_satisfaction = Satisfaction
	Strenght = gen_stat()
	Dexterity = gen_stat()
	Intelligence = gen_stat()
	Healthbar =get_node("VBoxContainer/HealthBar")
	satisfaction_bar = get_node("VBoxContainer/SatisfactionBar")
	Worldnode = get_tree().get_root().get_node("World")
	world_map = get_tree().get_root().get_node("World/WorldMap")
	update_stats()
	update_pos()

func gen_stat() -> float:
	return rng.randi_range(1, 6) + rng.randi_range(1, 6) + rng.randi_range(1, 6) as float
	
func update_stats():
	Healthbar.set_text("HP:{current}/{max}".format({"current": CurrentHealth, "max": Health}))
	satisfaction_bar.set_text("SP:{current}/{max}".format({"current": current_satisfaction, "max": Satisfaction}))
	
func update_pos():
	position = Worldnode.world_map.map_to_world(Pos) + Vector2(16,16)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):



func _on_SatisfactionDecay_timeout():
	current_satisfaction -= 1
	update_stats()


func _on_ExplorationTimer_timeout():
	var random = rng.randi_range(1,4)
	if random == 1: #move east
		Pos = Pos + Vector2(1,0)
	elif random == 2: #move south
		Pos = Pos + Vector2(0,1)
	elif random == 3: #move west
		Pos = Pos + Vector2(-1,0)
	elif random == 4: #move north
		Pos = Pos + Vector2(0,-1)
	update_pos()
	if world_map.world_tile_map.get_cellv(Pos) == -1:
		current_satisfaction -= 10
		update_stats()

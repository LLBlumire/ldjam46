extends Node2D
class_name Adventurer

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var Healthbar : Label
var Worldnode : Node2D

var Health : float = 0.0 
var CurrentHealth : float = 0.0
var Satisfaction : float = 0.0
var Strenght : float = 0.0
var Dexterity : float = 0.0
var Intelligence : float = 0.0
var Pos : Vector2 = Vector2(-3,2)
var rng = RandomNumberGenerator.new()
# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()
	Health = 20 + gen_stat()
	CurrentHealth = Health
	Satisfaction = 20 + gen_stat()
	Strenght = gen_stat()
	Dexterity = gen_stat()
	Intelligence = gen_stat()
	Healthbar =get_node("HealthBar")
	Worldnode = get_tree().get_root().get_node("World")
	update_stats()
	 # Replace with function body.

func gen_stat() -> float:
	return rng.randi_range(1, 6) + rng.randi_range(1, 6) + rng.randi_range(1, 6) as float
	
func update_stats():
	Healthbar.set_text("HP:{current}/{max}".format({"current": CurrentHealth, "max": Health}))
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position = Worldnode.world_map.map_to_world(Pos) + Vector2(16,16)

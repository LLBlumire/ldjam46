extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var spawn_delay: float = 0.0
var enemy_scene
export var center = Vector2(128, 70)
export var distance = 150
var world

# Called when the node enters the scene tree for the first time.
func _ready():
	enemy_scene = load("res://src/Enemy.tscn")
	world = get_tree().get_root().get_node("World")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	spawn_delay -= delta
	if spawn_delay <= 0:
		spawn_delay += world.s_remaining * (1.0/60.0)
		var new_enemy = enemy_scene.instance()
		new_enemy.transform.origin = Vector2(distance, 0).rotated(randf() * PI * 2) + center;
		new_enemy.active = true
		add_child(new_enemy)

func damage_player(fire):
	remove_child(fire)
	world.s_remaining -= 1

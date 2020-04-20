extends Button


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_RestartGame_pressed():
	var world = get_node(NodeMgr.world)
	var new_world = load("res://src/World/World.tscn").instance()
	var world_p = world.get_parent()
	world_p.remove_child(world)
	world_p.add_child(new_world)
	hide()
	get_node(NodeMgr.camera).world = new_world
	new_world.begin()

func _on_World_game_over():
	show()

extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var world_map
var click_cursor : Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	world_map = get_tree().get_root().get_node("World/WorldMap")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):




func kill_self():
	get_parent().remove_child(self)

func _on_Village_pressed():
	world_map.place_tile(click_cursor,0)
	kill_self()


func _on_Grassland_pressed():
	world_map.place_tile(click_cursor,1)
	kill_self()


func _on_Forest_pressed():
	world_map.place_tile(click_cursor,3)
	kill_self()

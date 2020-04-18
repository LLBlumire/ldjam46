extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var world: GameWorld

# Called when the node enters the scene tree for the first time.
func _ready():
	world = get_tree().get_root().get_node("World")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_select"):
		if get_rect().has_point(get_local_mouse_position()):
			print("eyylmao")


func _on_WorldMap_tile_clicked(tile: Vector2):
	position = world.world_map.world_tile_map.map_to_world(tile)

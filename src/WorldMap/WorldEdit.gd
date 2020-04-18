extends TileMap
class_name WorldEdit

const SELECTED: int = 0

var cursor: Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	cursor = Vector2(0, 0)

func _process(delta):
	clear_cursor()
	cursor = world_to_map(get_global_mouse_position())
	place_cursor()
	
func place_cursor():
	set_cellv(cursor, 0)
	
func clear_cursor():
	set_cellv(cursor, -1)

extends Camera2D

const CELL_PAD : Vector2 = Vector2(48, 48)

var world : GameWorld

# Called when the node enters the scene tree for the first time.
func _ready():
	world = get_node("../World")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var top_left = world.world_map.lower_bounds - CELL_PAD
	var bottom_right = world.world_map.upper_bounds + CELL_PAD
	set_position((top_left + bottom_right) / 2)
	var vsize := get_viewport_rect().size
	var size = bottom_right - top_left
	var vscale = size / vsize
	var fscale = max(vscale.x, vscale.y)
	vscale = Vector2(fscale, fscale)
	zoom = lerp(zoom, vscale, delta)

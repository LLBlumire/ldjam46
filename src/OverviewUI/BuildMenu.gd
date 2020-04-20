extends GridContainer

signal build_mode_set

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_TownButton_pressed():
	emit_signal("build_mode_set", TileData.TOWN)

func _on_GrasslandButton_pressed():
	emit_signal("build_mode_set", TileData.GRASSLAND)

func _on_FarmlandButton_pressed():
	emit_signal("build_mode_set", TileData.FARMLAND)

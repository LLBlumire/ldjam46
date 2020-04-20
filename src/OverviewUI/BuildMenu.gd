extends GridContainer

signal build_mode_set

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var audio_select: AudioStreamPlayer2D
var audio_bg_default : AudioStreamPlayer2D

# Called when the node enters the scene tree for the first time.
func _ready():
	audio_select = get_node(NodeMgr.audio_select)
	audio_bg_default = get_node(NodeMgr.audio_bg_default)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func set_build_mode(tile: int):
	audio_select.play()
	emit_signal("build_mode_set", tile)

func _on_TownButton_pressed():
	set_build_mode(TileData.TOWN)

func _on_GrasslandButton_pressed():
	set_build_mode(TileData.GRASSLAND)

func _on_FarmlandButton_pressed():
	set_build_mode(TileData.FARMLAND)

func _on_ForestButton_pressed():
	set_build_mode(TileData.WOODS)

func _on_CaveButton_pressed():
	set_build_mode(TileData.CAVES)

func _on_SwampButton_pressed():
	set_build_mode(TileData.SWAMP)

func _on_MountainButton_pressed():
	set_build_mode(TileData.MOUNTAIN)

func _on_DesertButton_pressed():
	set_build_mode(TileData.DESERT)

func _on_JungleButton_pressed():
	set_build_mode(TileData.JUNGLE)

func _on_AlpineButton_pressed():
	set_build_mode(TileData.ALPINE)

func _on_ArcticButton_pressed():
	set_build_mode(TileData.ARCTIC)
	

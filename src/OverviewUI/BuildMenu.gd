extends GridContainer

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var audio_select: AudioStreamPlayer
var audio_bg_default : AudioStreamPlayer
var audio_bg_hostile : AudioStreamPlayer
var audio_bg_friendly : AudioStreamPlayer
var world

# Called when the node enters the scene tree for the first time.
func _ready():
	audio_select = get_node(NodeMgr.audio_select)
	audio_bg_default = get_node(NodeMgr.audio_bg_default)
	audio_bg_hostile = get_node(NodeMgr.audio_bg_hostile)
	audio_bg_friendly = get_node(NodeMgr.audio_bg_friendly)
	world = get_node(NodeMgr.world)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func set_build_mode(tile: int):
	audio_select.play()
	world._on_BuildMenu_build_mode_set(tile)

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
	
func _on_MuteButton_pressed():
	audio_bg_default.stop()
	audio_bg_friendly.stop()
	audio_bg_hostile.stop()
	get_node(NodeMgr.chat_log).post_message("[center][i]Music Disabled[/i][/center]")

func _on_FriendlyButton_pressed():
	audio_bg_default.stop()
	audio_bg_friendly.stop()
	audio_bg_hostile.stop()
	audio_bg_friendly.play()
	get_node(NodeMgr.chat_log).post_message("[center][i]Now Playing: Floating Castles[/i][/center]")

func _on_DefaultButton_pressed():
	audio_bg_default.stop()
	audio_bg_friendly.stop()
	audio_bg_hostile.stop()
	audio_bg_default.play()
	get_node(NodeMgr.chat_log).post_message("[center][i]Now Playing: Anthem of Shrea[/i][/center]")

func _on_HostileButton_pressed():
	audio_bg_default.stop()
	audio_bg_friendly.stop()
	audio_bg_hostile.stop()
	audio_bg_hostile.play()
	get_node(NodeMgr.chat_log).post_message("[center][i]Now Playing: Murky Cavern[/i][/center]")

extends RichTextLabel
class_name ChatLog

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	add_color_override("default_color", Color(0,0,0,1))

func post_message(message):
	bbcode_text += "\n{message}".format({"message": message})

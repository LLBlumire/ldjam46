extends KinematicBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var move_speed: float = 1;
export var active: bool = false;

var player
var world
var sprite

# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_tree().get_root().get_node("World/Bob");
	world = get_tree().get_root().get_node("World")
	sprite = get_node("FireSprite")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !active:
		return
	var d = (player.transform.origin - transform.origin).normalized()
	sprite.set_flip_h(d.x > 0)
	var collision_data = self.move_and_collide(d * move_speed * delta);
	if collision_data != null:
		if collision_data.collider.get_collision_layer() == 2:
			get_parent().damage_player(self)
			
func kill_self():
	world.score += 1
	get_parent().remove_child(self)

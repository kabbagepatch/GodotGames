extends Area2D
class_name Rocket

var speed = 300
var screen_size

func _ready():
	screen_size = get_viewport_rect().size

func _process(delta):
	if (position.y > screen_size.y + 10):
		queue_free()
	
	position.y += delta * speed

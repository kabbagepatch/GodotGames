extends Area2D
class_name Powerup

var speed = 100
var screen_size

func _ready() -> void:
	screen_size = get_viewport_rect().size

func _process(delta: float) -> void:
	position.y += speed * delta
	if position.y > screen_size.y:
		queue_free()

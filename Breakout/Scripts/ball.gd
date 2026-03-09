extends Area2D

var speed = 200
var screen_size
var velocity = Vector2(1, -1)

func _ready() -> void:
	screen_size = get_viewport_rect().size

func _process(delta: float) -> void:
	if position.y >= screen_size.y or position.y <= 0:
		velocity.y = -1 * velocity.y
	elif position.x >= screen_size.x or position.x <= 0:
		velocity.x = -1 * velocity.x

	var normalized_velocity = velocity * speed

	position += normalized_velocity * delta
	position = position.clamp(Vector2.ZERO, Vector2(screen_size.x, screen_size.y))

func _on_area_entered(area: Area2D) -> void:
	if area is Brick:
		area.queue_free()
		velocity.y = -1 * velocity.y

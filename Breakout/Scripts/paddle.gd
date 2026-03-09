extends Area2D

var speed = 400
var screen_size
const WIDTH = 48

func _ready() -> void:
	screen_size = get_viewport_rect().size

func _process(delta: float) -> void:
	var velocity = Vector2.ZERO

	if Input.is_action_pressed("paddle_right"):
		velocity.x += 1
	if Input.is_action_pressed("paddle_left"):
		velocity.x -= 1
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
	position += velocity * delta
	position = position.clamp(Vector2(WIDTH, 0), Vector2(screen_size.x - WIDTH, screen_size.y))

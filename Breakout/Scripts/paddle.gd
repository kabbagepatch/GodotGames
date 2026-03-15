extends CharacterBody2D
class_name Paddle

var game_state = 'READY'
var speed = 450
var screen_size
const WIDTH = 32 * 3

func _ready() -> void:
	screen_size = get_viewport_rect().size

func _process(delta: float) -> void:
	if game_state != 'PLAY':
		return
	velocity = Vector2.ZERO
	if Input.is_action_pressed("paddle_right"):
		velocity.x += 1
	if Input.is_action_pressed("paddle_left"):
		velocity.x -= 1
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
	position += velocity * delta
	position = position.clamp(Vector2(WIDTH / 2, 0), Vector2(screen_size.x - WIDTH / 2, screen_size.y))

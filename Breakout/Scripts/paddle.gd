extends Area2D

var speed = 450
var screen_size
const WIDTH = 32 * 3
@onready var ball: Area2D = $"../Ball"

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
	position = position.clamp(Vector2(WIDTH / 2, 0), Vector2(screen_size.x - WIDTH / 2, screen_size.y))

func _on_area_entered(area: Area2D) -> void:
	ball.velocity.y = -1 * ball.velocity.y
	ball.velocity.x = (ball.position.x - position.x) / ((WIDTH - 10) / 2)
	#if position.x > ball.position.x:
		#ball.velocity.x = -1
	#if position.x < ball.position.x:
		#ball.velocity.x = 1

extends Node2D

signal player_scored

@export var speed = 400
var screen_size
@export var velocity = Vector2.ZERO
var rng = RandomNumberGenerator.new()

func _ready():
	screen_size = get_viewport_rect().size
	reset()

func _process(delta):
	if position.y >= screen_size.y:
		velocity.y = -1 * velocity.y
	elif position.y <= 0:
		velocity.y = -1 * velocity.y
	elif position.x >= screen_size.x:
		player_scored.emit(1)
	elif position.x <= 0:
		player_scored.emit(2)

	var normalized_velocity = velocity.normalized() * speed

	position += normalized_velocity * delta
	position = position.clamp(Vector2.ZERO, Vector2(screen_size.x, screen_size.y))

func reset():
	position = Vector2(screen_size.x / 2, screen_size.y / 2)
	velocity = Vector2.ZERO

func start(x):
	velocity = Vector2(x, rng.randf_range(-1, 1))

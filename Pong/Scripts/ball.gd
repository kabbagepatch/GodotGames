extends Node2D

signal edge_hit

@export var speed = 400
var screen_size
@export var velocity = Vector2.ZERO

func _ready():
	screen_size = get_viewport_rect().size
	reset(1)

func _process(delta):
	if position.y >= screen_size.y:
		velocity.y = -1
	elif position.y <= 0:
		velocity.y = 1
	elif position.x >= screen_size.x:
		velocity.x = -1
		edge_hit.emit(2)
	elif position.x <= 0:
		velocity.x = 1
		edge_hit.emit(1)

	var normalized_velocity = velocity.normalized() * speed

	position += normalized_velocity * delta
	position = position.clamp(Vector2.ZERO, Vector2(screen_size.x, screen_size.y))

func reset(x):
	position = Vector2(screen_size.x / 2, screen_size.y / 2)
	start(x)

func start(x):
	velocity = Vector2(x, (randi() % 2) * 2 - 1)

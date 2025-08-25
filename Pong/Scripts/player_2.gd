extends Area2D

signal p2_hit

@onready var ball: StaticBody2D = $"../Ball"
@onready var world: Node2D = $".."

@export var speed = 400
var screen_size
var y_limit = 30
var rng = RandomNumberGenerator.new()
@export var mode = "HUMAN"
@export var computer_start = false
var computer_velocity = 0
var computer_threshold = 40

func _ready():
	screen_size = get_viewport_rect().size

func _process(delta):
	if !world.game_started:
		return
	
	var velocity = Vector2.ZERO

	if mode == "HUMAN":
		if Input.is_action_pressed("player_two_move_down"):
			velocity.y += 1
		if Input.is_action_pressed("player_two_move_up"):
			velocity.y -= 1
	elif computer_start:
		if position.y > ball.position.y + computer_threshold:
			velocity.y = computer_velocity * -1
		elif position.y < ball.position.y - computer_threshold:
			velocity.y = computer_velocity

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed

	position += velocity * delta
	position = position.clamp(Vector2(0, y_limit), Vector2(screen_size.x, screen_size.y - y_limit))

func _on_body_entered(_body: Node2D) -> void:
	p2_hit.emit()
	computer_start = false

func _on_player_1_p_1_hit() -> void:
	if mode == "HUMAN":
		return

	computer_start = true
	if mode == "EASY":
		computer_velocity = rng.randf_range(0.5, 0.8)
		computer_threshold = rng.randf_range(20, 55)
	elif mode == "MEDIUM":
		computer_velocity = rng.randf_range(0.5, 0.9)
		computer_threshold = rng.randf_range(20, 40)
	elif mode == "HARD":
		computer_velocity = rng.randf_range(0.6, 1)
		computer_threshold = rng.randf_range(15, 25)
	print(computer_velocity, ", ", computer_threshold)

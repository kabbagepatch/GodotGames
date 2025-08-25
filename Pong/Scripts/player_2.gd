extends Area2D

signal p2_hit

@onready var ball: StaticBody2D = $"../Ball"

@export var speed = 400
var screen_size
var y_limit = 30
@export var game_started = false
var rng = RandomNumberGenerator.new()
var mode = "AI"
var ai_start = false
var ai_velocity = 0
var ai_threshold = 40

func _ready():
	screen_size = get_viewport_rect().size

func _process(delta):
	if !game_started:
		return
	
	var velocity = Vector2.ZERO

	if mode == "HUMAN":
		if Input.is_action_pressed("player_two_move_down"):
			velocity.y += 1
		if Input.is_action_pressed("player_two_move_up"):
			velocity.y -= 1
	elif ai_start:
		if position.y > ball.position.y + ai_threshold:
			velocity.y = ai_velocity * -1
		elif position.y < ball.position.y - ai_threshold:
			velocity.y = ai_velocity

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed

	position += velocity * delta
	position = position.clamp(Vector2(0, y_limit), Vector2(screen_size.x, screen_size.y - y_limit))

func _on_body_entered(_body: Node2D) -> void:
	p2_hit.emit()
	ai_start = false

func _on_player_1_p_1_hit() -> void:
	ai_velocity = rng.randf_range(0.5, 1)
	ai_threshold = rng.randf_range(20, 40)
	ai_start = true

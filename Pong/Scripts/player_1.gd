extends Area2D

signal p1_hit

@onready var player_2: Area2D = $"../Player2"
@onready var world: Node2D = $".."

@export var speed = 400
var screen_size
var y_limit = 30

func _ready():
	screen_size = get_viewport_rect().size

func _process(delta):
	if !world.game_started:
		return
	var velocity = Vector2.ZERO

	if Input.is_action_pressed("player_one_move_down"):
		velocity.y += 1
	if Input.is_action_pressed("player_one_move_up"):
		velocity.y -= 1
	if player_2.mode != "HUMAN":
		if Input.is_action_pressed("player_two_move_down"):
			velocity.y += 1
		if Input.is_action_pressed("player_two_move_up"):
			velocity.y -= 1

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed

	position += velocity * delta
	position = position.clamp(Vector2(0, y_limit), Vector2(screen_size.x, screen_size.y - y_limit))


func _on_body_entered(_body: Node2D) -> void:
	p1_hit.emit()

extends Area2D

signal p1_hit

@export var speed = 400
var screen_size
var y_limit = 30

func _ready():
	screen_size = get_viewport_rect().size

func _process(delta):
	var velocity = Vector2.ZERO # The player's movement vector.
	
	if Input.is_action_pressed("player_one_move_down"):
		velocity.y += 1
	if Input.is_action_pressed("player_one_move_up"):
		velocity.y -= 1
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed

	position += velocity * delta
	position = position.clamp(Vector2(0, y_limit), Vector2(screen_size.x, screen_size.y - y_limit))


func _on_body_entered(_body: Node2D) -> void:
	p1_hit.emit()

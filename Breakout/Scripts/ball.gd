extends CharacterBody2D

var game_state = 'READY'
var speed = 3
var screen_size
const PADDLE_WIDTH = 32 * 3

func _ready() -> void:
	velocity = Vector2.ZERO
	screen_size = get_viewport_rect().size

func _physics_process(delta: float) -> void:
	if game_state != 'PLAY':
		return
	if position.y >= screen_size.y or position.y <= 0:
		velocity.y = -1 * velocity.y
	elif position.x >= screen_size.x or position.x <= 0:
		velocity.x = -1 * velocity.x

	var normalized_velocity = velocity * speed
	var collision = move_and_collide(normalized_velocity)
	if collision:
		var collider = collision.get_collider()
		if collider is Paddle:
			velocity.x = (position.x - collider.position.x) / ((PADDLE_WIDTH - 10) / 2.5)
			velocity.y = -1
			speed = 3
		elif collider is Brick:
			var normal = collision.get_normal()
			if normal.y > 0: velocity.y = 1 * abs(velocity.y)
			if normal.y < 0: velocity.y = -1 * abs(velocity.y)
			if normal.x > 0: velocity.x = 1 * abs(velocity.x)
			if normal.x < 0: velocity.x = -1 * abs(velocity.x)
			collider.hit()
			speed += 0.1

extends CharacterBody2D

signal life_lost
@onready var blip: AudioStreamPlayer = $Blip

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
	if position.y >= screen_size.y:
		life_lost.emit()
	elif position.y <= 0:
		velocity.y = -1 * velocity.y
	elif position.x >= screen_size.x or position.x <= 0:
		velocity.x = -1 * velocity.x

	var normalized_velocity = velocity * speed
	var collision = move_and_collide(normalized_velocity)
	if collision:
		blip.play()
		var collider = collision.get_collider()
		if collider is Paddle:
			var current_velocity = velocity.length()
			var collision_point = collision.get_position()
			var relative_hit_position = (collision_point.x - collider.global_position.x) / (PADDLE_WIDTH / 2)
			var deflection_angle = deg_to_rad(45.0) * relative_hit_position
			velocity = Vector2.UP.rotated(deflection_angle).normalized() * current_velocity
			speed -= 0.05
		elif collider is Wall:
			velocity.x = -1 * velocity.x
		elif collider is Brick:
			var normal = collision.get_normal()
			if normal.y > 0: velocity.y = 1 * abs(velocity.y)
			if normal.y < 0: velocity.y = -1 * abs(velocity.y)
			if normal.x > 0: velocity.x = 1 * abs(velocity.x)
			if normal.x < 0: velocity.x = -1 * abs(velocity.x)
			collider.hit()
			if speed < 6:
				speed += 0.05

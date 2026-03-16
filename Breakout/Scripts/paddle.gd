extends CharacterBody2D
class_name Paddle
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var powerup_timer: Timer = $PowerupTimer
@onready var power_up_sound: AudioStreamPlayer = $PowerUpSound
@onready var power_down_sound: AudioStreamPlayer = $PowerDownSound

var game_state = 'READY'
var speed = 500
var screen_size
var width = 32 * scale.x

func _ready() -> void:
	screen_size = get_viewport_rect().size
	sprite_2d.frame = 1

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
	position = position.clamp(Vector2(width / 2, 0), Vector2(screen_size.x - width / 2, screen_size.y))

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area is Powerup:
		if powerup_timer.is_stopped():
			scale.x += 1
			width = 32 * scale.x
			sprite_2d.frame += 2
		power_up_sound.play()
		powerup_timer.start()
		area.queue_free()

func _on_powerup_timer_timeout() -> void:
	power_down_sound.play()
	scale.x -= 1
	width = 32 * scale.x
	sprite_2d.frame -= 2

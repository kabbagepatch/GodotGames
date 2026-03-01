extends Area2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

@export var game_over = 0
var speed = 400
var screen_size
var x_limit = 30

signal killed

func _ready():
	screen_size = get_viewport_rect().size

func _process(delta):
	if game_over: return
	if !visible: return

	var velocity = Vector2.ZERO
	
	if Input.is_action_pressed("left"):
		velocity.x -= 1
	if Input.is_action_pressed("right"):
		velocity.x += 1
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
	
	position += velocity * delta
	position = position.clamp(Vector2(x_limit, 0), Vector2(screen_size.x - x_limit, screen_size.y))

func _on_area_entered(area: Area2D) -> void:
	if area is Rocket:
		animation_player.play("destroy")
		area.queue_free()

	if area is Enemy:
		killed.emit(true)

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == 'destroy':
		animation_player.play("RESET")
		killed.emit(false)

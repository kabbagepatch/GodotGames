extends Area2D

@export var sprite: Sprite2D;
@export var sprite_array: Array[Texture2D]

var damage = 0
const MAX_DAMAGE = 3

func _ready():
	self.area_entered.connect(_on_area_entered)

func _on_area_entered(area: Area2D) -> void:
	if area is Rocket or area is Laser:
		area.queue_free()
		if damage < MAX_DAMAGE:
			damage += 1
			sprite.texture = sprite_array[damage - 1]
		else:
			queue_free()
	
	if area is Enemy:
		queue_free()

extends CanvasLayer

@onready var message: Label = $Message
@onready var score: Label = $Score
@onready var message_timer: Timer = $MessageTimer
@onready var separator: Sprite2D = $"../Separator"

func show_message(score_text, message_text, game_over=false):
	score.text = score_text
	score.show()
	message.text = message_text
	message.show()
	if not game_over:
		message_timer.start(1.5)

func _on_message_timer_timeout() -> void:
	message.hide()
	score.hide()	
	separator.show()

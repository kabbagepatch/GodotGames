extends CanvasLayer

@onready var score: Label = $Score
@onready var message: Label = $Message
@onready var life_1: Sprite2D = $Life1
@onready var life_2: Sprite2D = $Life2
@onready var life_3: Sprite2D = $Life3

func update_score(new_score):
	score.text = ("%s" % new_score)

func update_lives(lives):
	life_1.hide()
	if lives == 1:
		life_2.hide()
	if lives == 0:
		life_3.hide()

func show_message(score = 0):
	if score:
		message.text = 'YOU WIN!'
	message.show()

func hide_message():
	message.hide()

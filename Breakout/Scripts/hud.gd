extends CanvasLayer

@onready var score: Label = $Score
@onready var score_message: Label = $ScoreMessage
@onready var message: Label = $Message
@onready var life_1: Sprite2D = $Life1
@onready var life_2: Sprite2D = $Life2
@onready var life_3: Sprite2D = $Life3

func update_message(new_message):
	message.text = ("%s" % new_message)

func update_score(new_score):
	score.text = ("%s" % new_score)

func update_lives(lives):
	life_1.hide()
	if lives == 1:
		life_2.hide()
	if lives == 0:
		life_3.hide()

func show_message():
	message.show()

func hide_message():
	message.hide()

func show_score_message(total_score, rank):
	var msg
	if rank == -1:
		msg = "Score: %d" % total_score
	else:
		if rank == 1:
			msg = "New High Score: %d!" % total_score
		else:
			msg = "You placed #%d: %d!" % [rank, total_score]
	score_message.text = msg
	score_message.show()

func hide_score_message():
	score_message.hide()

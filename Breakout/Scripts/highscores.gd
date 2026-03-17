extends Node
class_name HighScore

const HIGHSCORES_FILE = "user://highscores.txt"

func save_high_scores(new_score):
	var scores = load_high_scores()
	var dt = Time.get_datetime_dict_from_system()
	var datetime_str = "%02d/%02d/%04d %02d:%02d" % [
		dt["month"], dt["day"], dt["year"],
		dt["hour"], dt["minute"]
	]
	scores.append({ "datetime": datetime_str, "score": new_score })
	scores.sort_custom(func(a, b): return a["score"] > b["score"])
	if scores.size() > 10: scores = scores.slice(0, 10)

	var file = FileAccess.open(HIGHSCORES_FILE, FileAccess.WRITE)
	for entry in scores:
		file.store_line("%s,%d" % [entry["datetime"], entry["score"]])
	file.close()

	for i in scores.size():
		if scores[i]["datetime"] == datetime_str and scores[i]["score"] == new_score: return i + 1

	return -1

func load_high_scores():
	if not FileAccess.file_exists(HIGHSCORES_FILE):
		return []

	var scores = []
	var file = FileAccess.open(HIGHSCORES_FILE, FileAccess.READ)
	while not file.eof_reached():
		var line = file.get_line().strip_edges()
		var parts = line.split(",")
		if parts.size() == 2: 
			scores.append({
				"datetime": parts[0],
				"score": parts[1].to_int()
			})
	file.close()
	return scores

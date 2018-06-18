extends Node

const SAVE = 'user://data1.ns'
const PASS = 'https://www.youtube.com/watch?v=3bNITQR4Uso'
var F = File.new()
var last_score = 0
var best_score = 0


func _ready():
	load_data()

func load_data():
	if F.file_exists(SAVE):
		if F.open_encrypted_with_pass(SAVE, File.READ, PASS) == OK:
			var data = F.get_var()
			best_score = data.best_score
			F.close()
		else:
			Directory.new().remove(SAVE)
			save_data()
	else:
		save_data()

func save_data():
	if F.open_encrypted_with_pass(SAVE, File.WRITE, PASS) == OK:
		F.store_var({'best_score': best_score})
		F.close()

func update_highscore(score):
	last_score = score
	if last_score > best_score:
		best_score = last_score
		save_data()

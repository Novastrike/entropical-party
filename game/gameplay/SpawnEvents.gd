extends Node

signal spawn_at(food, at)
signal plastic_sun

const MEAT = preload('res://game/gameplay/foods/Meat.tscn')
const GELATO = preload('res://game/gameplay/foods/Gelato.tscn')
const FOODS = {'meat': MEAT, 'gelato': GELATO}
const RANGE = [0, 1600]


const Events = {
#	[0, 999]: { # Debug wave
#		'meat_rate': 0.2,
#		'food_interval': 5.0,
#		'speed': 0.1,
#		'plastic_interval': 30.0,
#	},
	[0, 300]: { # Wave 1
		'meat_rate': 0.5,
		'food_interval': 3.0,
		'speed': 0.3,
		'plastic_interval': 0,
	},
	[300, 600]: { # Wave 2
		'meat_rate': 0.5,
		'food_interval': 3.0,
		'speed': 0.35,
		'plastic_interval': 0,
	},
	[600, 1000]: { # Wave 3
		'meat_rate': 0.6,
		'food_interval': 2.5,
		'speed': 0.4,
		'plastic_interval': 50.0,
	},
	[1000, 1500]: { # Wave 4
		'meat_rate': 0.65,
		'food_interval': 2.2,
		'speed': 0.41,
		'plastic_interval': 40.0,
	},
	[1500, 3000]: { # Wave 5
		'meat_rate': 0.67,
		'food_interval': 2.0,
		'speed': 0.42,
		'plastic_interval': 30.0,
	},
}


var current_event = [-1, 0] # HAXX
onready var food_t = $FoodTimer
onready var plastic_t = $PlasticTimer

func spawn_at(food_name, at):
	if not get_signal_connection_list('spawn_at').empty():
		var food = FOODS[food_name].instance()
		food.gravity_scale = Events[current_event].speed
		emit_signal('spawn_at', food, at)

func play_plastic_sun():
	emit_signal('plastic_sun')

func create_food_timer():
	food_t.stop()
	food_t.wait_time = Events[current_event].food_interval
	food_t.start()

func create_plastic_timer():
	if Events[current_event].plastic_interval > 0.0:
		plastic_t.stop()
		plastic_t.wait_time = Events[current_event].plastic_interval
		plastic_t.start()


func _on_score_update(score):
	if not score in range(current_event[0], current_event[1]):
		for key in Events:
			if score in range(key[0], key[1]):
				if current_event != key:
					current_event = key
					create_food_timer()
					create_plastic_timer()
				break

func _on_FoodTimer_timeout():
	var food = 'meat' if randf() <= Events[current_event].meat_rate else 'gelato'
	spawn_at(food, Vector2(rand_range(RANGE[0], RANGE[1]), -20))

func _on_PlasticTimer_timeout():
	play_plastic_sun()

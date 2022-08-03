# Original demo at  https://godotengine.org/asset-library/asset/528

extends Node2D

const VU_COUNT = 500
const FREQ_MAX = 31050.0
#const FREQ_MAX = 11050.0

const WIDTH = 1200
const HEIGHT = 300

const MIN_DB = 60

@onready var spectrum := AudioServer.get_bus_effect_instance(0,0)

#func _ready():
#	spectrum = AudioServer.get_bus_effect_instance(0,0)

func _draw():
	#warning-ignore:integer_division
	var w = WIDTH / VU_COUNT
	var prev_hz = 0
	for i in range(1, VU_COUNT+1):
		var hz = i * FREQ_MAX / VU_COUNT;
		var magnitude: float = spectrum.get_magnitude_for_frequency_range(prev_hz, hz).length()
		var energy = clamp((MIN_DB + linear2db(magnitude)) / MIN_DB, 0, 1)
		var height = energy * HEIGHT
		draw_rect(Rect2(w * i, HEIGHT - height, w, height), Color.WHITE)
		prev_hz = hz


func _process(_delta):
	update()




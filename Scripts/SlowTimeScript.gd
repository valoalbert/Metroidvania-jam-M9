extends Node

const END_VALUE : int = 1

var is_active : bool = false
var time_start
var duration_ms
var start_value

func _ready():
	Engine.time_scale = 1

func start(duration = 0.4, strength = 0.9):
	time_start = OS.get_ticks_msec()
	duration_ms = duration * 2000
	start_value = 1 - strength
	Engine.time_scale = start_value
	is_active = true
	
func _process(delta):
	if is_active:
		var current_time = OS.get_ticks_msec() - time_start
		var value = circle_ease_int(current_time, start_value, END_VALUE, duration_ms)
		if current_time >= duration_ms:
			is_active = false
			value = END_VALUE
		Engine.time_scale = value
		

# t: current time
# b: start value
# c: 	end value
# d: duration
func circle_ease_int(t,b,c,d):
	t /= d
	return -c* (sqrt(1-t*t)-1) + b

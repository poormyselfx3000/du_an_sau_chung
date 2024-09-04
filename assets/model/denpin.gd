extends Node3D

var SMOOTH_FACTOR = 0.1
@onready var pistol = $"../../../.."



func _process(delta):
	pistol.position.x = lerp(pistol.position.x,0.0,delta*5)
	pistol.position.y = lerp(pistol.position.y,0.0,delta*5)

func sway(sway_amount):
	pistol.position.x += sway_amount.x*0.000000005
	pistol.position.y += sway_amount.y*0.000000005

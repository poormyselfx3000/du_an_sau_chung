extends Area3D

@onready var character = $"../character"
@onready var key_animation = $key_animation


func _process(delta):
	if character.check_key == true:
		key_animation.play("pickup")
		await get_tree().create_timer(1).timeout
		queue_free()




class_name VungPhatHien extends Area3D

var player_in_the_area: CharacterBody3D = null

func _on_body_entered(body):
	if body.is_in_group("player"):
		print("Player Da Den")
		player_in_the_area = body

func _on_body_exited(body):
	if body.is_in_group("player"):
		print("Player Run Away")
		player_in_the_area = null

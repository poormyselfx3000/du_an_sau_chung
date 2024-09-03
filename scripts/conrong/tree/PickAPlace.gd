extends ActionLeaf


func tick(actor, blackboard: Blackboard):
	var spawn_location = Vector3(0,0,0)
	# just a ramdom but need to be a area later
	# will use this random for now 
	var new_position = Vector3(
		spawn_location.x + randf_range(-1000, 1000),
		spawn_location.z + randf_range(-1000, 1000),
		#spawn_location.y + randf_range(-1000, 1000)
		0
	)
	actor.set_target_position(new_position)
	return SUCCESS


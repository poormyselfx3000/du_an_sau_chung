extends ConditionLeaf


func tick(actor, blackboard: Blackboard):
	var player = actor.player_in_vung_phat_hien()
	if player:
		actor.set_target_position(player.position)
		return SUCCESS
	return FAILURE

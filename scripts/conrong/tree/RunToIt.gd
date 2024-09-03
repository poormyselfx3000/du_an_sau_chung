extends ActionLeaf

const DURATION = 99
var count = DURATION;

func tick(actor, blackboard: Blackboard):
	# Should be some useful logic. Like close to destionation or bored or sth
	#print("Running ", count)
	if count == 0:
		count = DURATION;
		return SUCCESS
	count -= 1
	return RUNNING

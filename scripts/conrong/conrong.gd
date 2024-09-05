extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5

var target: Vector3 = Vector3(0,0,0)

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func set_target_position(new_position: Vector3):
	target = new_position
	look_at(target)
 
#nav
@onready var nav: NavigationAgent3D = $NavigationAgent3D
	


#------- SLIME view

@onready var vung_phat_hien = $VungPhatHien

func tucgian():
	look_at(vung_phat_hien.player_in_the_area.position)
	
func vuive():
	pass


func player_in_vung_phat_hien() -> CharacterBody3D:
	return vung_phat_hien.player_in_the_area
#------- SLIME view

const ACCEL = 10

func _physics_process(delta):
	# Add the gravity.
	if velocity.length() >0 :
		$arealdragon/AnimationPlayer.play("ArmatureAction")
	
	if velocity.length() == 0 :
		$arealdragon/AnimationPlayer.stop()
	
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	var direction = Vector3()
	nav.target_position = target
	direction = nav.get_next_path_position() - global_position
	direction = direction.normalized()
	
	velocity = velocity.lerp(direction * SPEED, ACCEL * delta)

	move_and_slide()

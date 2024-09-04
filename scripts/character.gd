extends CharacterBody3D

@onready var head = $truccodinh
@onready var cam_animation = $cam_animation
@onready var hand_animation = $hand_animation

const SPEED = 3.5
const JUMP_VELOCITY = 4.5
var SMOOTH_FACTOR = 0.1
@export var mouse_sens = 0.1
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	if event is InputEventMouseMotion:
		rotate_y(deg_to_rad(-event.relative.x * mouse_sens))
		head.rotate_x(deg_to_rad(-event.relative.y * mouse_sens))
		head.rotation.x = clamp(head.rotation.x,deg_to_rad(-70),deg_to_rad(89))


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta * 2

	# Handle jump.
	if Input.is_action_just_pressed("space") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("a", "d", "w", "s")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
		if is_on_floor():
			cam_animation.play("camshake")
			hand_animation.play("hand_shake")
		else:
			cam_animation.play("jump")
			hand_animation.play("hand_jump")
	else:
		velocity.x = lerp(float(velocity.x), 0.0, SMOOTH_FACTOR)
		velocity.z = lerp(float(velocity.z), 0.0, SMOOTH_FACTOR)
		if is_on_floor():
			cam_animation.play("RESET")
			hand_animation.play("RESET")
		else:
			cam_animation.play("jump")
			hand_animation.play("hand_jump")
	move_and_slide()

extends CharacterBody3D

@onready var head = $truccodinh
@onready var cam_animation = $cam_animation
@onready var hand_animation = $hand_animation
@onready var warning = $warning
@onready var timer = $Timer

var show_text = ""
const SPEED = 3
const JUMP_VELOCITY = 4.5
var SMOOTH_FACTOR = 0.3
@export var mouse_sens = 0.1
var nearkey = false
var neardoor = false
var check_key = false
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	if event is InputEventMouseMotion:
		rotate_y(deg_to_rad(-event.relative.x * mouse_sens))
		head.rotate_x(deg_to_rad(-event.relative.y * mouse_sens))
		head.rotation.x = clamp(head.rotation.x,deg_to_rad(-55),deg_to_rad(89))


func _physics_process(delta):

	if not is_on_floor():
		velocity.y -= gravity * delta * 2

	if Input.is_action_just_pressed("space") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	if Input.is_action_just_pressed("interactive") and nearkey == true:
		check_key = true
		
	if Input.is_action_just_pressed("interactive") and neardoor == true and check_key == true and $"../door".open == false:
		$"../door".animation.play("open")
		$"../door".open = true
		text_set("mở được rồi này")
	elif Input.is_action_just_pressed("interactive") and neardoor == true and check_key == false and $"../door".open == false:
		text_set("cửa đã khóa, mình cần tìm chìa khóa để mở.")

		
	var input_dir = Input.get_vector("a", "d", "w", "s")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
		trang_thai_di_chuyen()
	else:
		velocity.x = lerp(float(velocity.x), 0.0, SMOOTH_FACTOR)
		velocity.z = lerp(float(velocity.z), 0.0, SMOOTH_FACTOR)
		trang_thai_dung_yen()
	move_and_slide()


func _on_key_body_entered(body):
	var target = body
	if target.is_in_group("player"):
		nearkey = true
		text_set("Ồ một chiếc chìa khóa")
		
func text_set(set_text):
	warning.clear()
	warning.add_text(set_text)
	timer.start()

func trang_thai_di_chuyen():
	if is_on_floor():
		cam_animation.play("camshake")
		hand_animation.play("hand_shake")
	else:
		cam_animation.play("jump")
		hand_animation.play("hand_jump")

func  trang_thai_dung_yen():
	if is_on_floor():
		cam_animation.play("RESET")
		hand_animation.play("RESET")
	else:
		cam_animation.play("jump")
		hand_animation.play("hand_jump")

func _on_key_body_exited(body):
	var target = body
	if target.is_in_group("player"):
		nearkey = false


func _on_door_body_entered(body):
	var target = body
	if target.is_in_group("player"):
		neardoor = true


func _on_door_body_exited(body):
	var target = body
	if target.is_in_group("player"):
		neardoor = false


func _on_timer_timeout():
	text_set("...")

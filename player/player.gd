extends CharacterBody3D

const WALK_SPEED := 4.5
const SPRINT_SPEED := 7.5
const JUMP_HEIGHT := 1.0
const SENSITIVITY := 0.003
const FALL_MULTIPLIER := 2.5

# screen bob variables
const BOB_FREQ := 3
const BOB_AMP := 0.04
var t_bob := 0.0

# fov variables
const BASE_FOV := 75.0
const FOV_CHANGE := 0.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")
var speed := WALK_SPEED

@onready var head: Node3D = $Head
@onready var camera: Camera3D = $Head/Camera3D
@onready var grab_ray: RayCast3D = $Head/Camera3D/GrabRay
@onready var hand: Node3D = $Head/Camera3D/hand

@export var pickups_manager: Node3D

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		head.rotate_y(-event.relative.x * SENSITIVITY)
		camera.rotate_x(-event.relative.y * SENSITIVITY)
		camera.rotation.x = clamp(camera.rotation.x, deg_to_rad(-75), deg_to_rad(75))

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		if (velocity.y >= 0):
			velocity.y -= gravity * delta
		else: 
			velocity.y -= gravity * delta * FALL_MULTIPLIER

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = sqrt(2 * JUMP_HEIGHT * gravity)

	#Handle sprint
	if Input.is_action_pressed("sprint"):
		speed = SPRINT_SPEED
	else:
		speed = WALK_SPEED

	# Get the input direction and handle the movement/deceleration.
	var input_dir := Input.get_vector("move_left", "move_right", "move_front", "move_back")
	var direction := (head.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if is_on_floor():
		if direction:
			velocity.x = direction.x * speed
			velocity.z = direction.z * speed
		else:
			velocity.x = lerp(velocity.x, direction.x * speed, delta * 10.0)
		velocity.z = lerp(velocity.z, direction.z * speed, delta * 10.0)
	else:
		velocity.x = lerp(velocity.x, direction.x * speed, delta * 3.0)
		velocity.z = lerp(velocity.z, direction.z * speed, delta * 3.0)
		
	#screen bob
	#t_bob += delta * velocity.length() * float(is_on_floor())
	#camera.transform.origin = _headbob(t_bob)
	
	# fov
	#var velocity_clamped = clamp(velocity.length(), 0.2, SPRINT_SPEED * 2)
	#var target_fov = BASE_FOV + FOV_CHANGE * velocity_clamped
	#camera.fov = lerp(camera.fov, target_fov, delta * 10.0)
	
	handle_pickup(delta)
	move_and_slide()
	
func handle_pickup(delta: float) -> void:
	# handle grab
	if Input.is_action_just_pressed("grab"):
		if not grab_ray.is_colliding():
			return
		
		var object := grab_ray.get_collider()
		if not (object is pickup_object):
			return
		
		var obj_position: Vector3 = object.global_position
		var obj_rotation: Vector3 = object.global_rotation
	
		object.get_parent().remove_child(object)
		hand.add_child(object)
		object.global_position = obj_position
		object.global_rotation = obj_rotation
		
		object.handle_grab()
		
	if Input.is_action_pressed("grab"):
		for child in hand.get_children():
			child.global_position = lerp(child.global_position, hand.global_position, delta * 5.0)
			child.global_rotation = lerp(child.global_rotation, hand.global_rotation, delta * 5.0)
		
	# handle drop
	if Input.is_action_just_released("grab"):
		for child in hand.get_children():
			var obj_position: Vector3 = child.global_position
			var obj_rotation: Vector3 = child.global_rotation
			
			hand.remove_child(child)
			pickups_manager.add_child(child)
			child.global_position = obj_position
			child.global_rotation = obj_rotation
			
			if child is pickup_object:
				child.handle_drop()

func _headbob(time) -> Vector3:
	var pos := Vector3.ZERO
	pos.y = sin(time * BOB_FREQ) * BOB_AMP
	pos.x = cos(time * BOB_FREQ / 2) * BOB_AMP
	return pos

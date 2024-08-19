extends RigidBody3D

class_name pickup_object

@onready var scale_controller: Node3D = $ScaleController
@onready var collidor: CollisionShape3D = $Collidor
@onready var pickup_collidor: CollisionShape3D = $pickuphelper/PickupCollidor
@onready var mass_label_controller: Node3D = $MassLabelController
@onready var mass_label: Label3D = $MassLabelController/MassLabel
@onready var init_mass_label_local_pos: Vector3 = mass_label.position

@export var initial_scale := 1.0
@export var max_scale := 1.5
@export var min_scale := 0.5

var current_scale: float = initial_scale:
	set(value):
		current_scale = clamp(value, min_scale, max_scale)
		
		collidor.scale = Vector3.ONE * current_scale
		scale_controller.scale = Vector3.ONE * current_scale
		mass_label_controller.scale = Vector3.ONE * current_scale
		
		if current_scale >= 1:
			pickup_collidor.scale = Vector3.ONE * current_scale
		
		print(current_scale)

func _ready() -> void:
	current_scale = initial_scale
	mass_label.text = "Mass: " + str(mass)

func _physics_process(delta: float) -> void:
	# position adjustment for mass label at any mass
	mass_label.global_position = (
		mass_label_controller.global_position + 
		init_mass_label_local_pos + 
		Vector3(0,current_scale - 0.9,0) # idk why this works but it does
		)

func handle_grab()-> void:
	print("pick")
	gravity_scale = 0
	#freeze = true
	#collidor.disabled = true
	
func handle_drop()-> void:
	print("drop")
	gravity_scale = 1
	#freeze = false
	#collidor.disabled = false

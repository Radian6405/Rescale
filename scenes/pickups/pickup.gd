extends RigidBody3D

class_name pickup_object

@onready var scale_controller: Node3D = $ScaleController
@onready var collidor: CollisionShape3D = $Collidor
@onready var pickup_collidor: CollisionShape3D = $pickuphelper/PickupCollidor

@export var initial_scale := 1.0
@export var max_scale := 1.5
@export var min_scale := 0.5

var current_scale: float = initial_scale:
	set(value):
		current_scale = clamp(value, min_scale, max_scale)
		scale_controller.scale = Vector3.ONE * current_scale
		collidor.scale = Vector3.ONE * current_scale
		
		if current_scale >= 1:
			pickup_collidor.scale = Vector3.ONE * current_scale
		
		print(current_scale)

func _ready() -> void:
	current_scale = initial_scale

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

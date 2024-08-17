extends RigidBody3D

class_name pickup_object

@onready var scale_controller: Node3D = $ScaleController
@onready var collidor: CollisionShape3D = $collidor

@export var initial_scale := 1.0
@export var max_scale := 1.5
@export var min_scale := 0.5

var current_scale: float = initial_scale:
	set(value):
		current_scale = clamp(value, min_scale, max_scale)
		scale_controller.scale = Vector3.ONE * current_scale
		collidor.scale = Vector3.ONE * current_scale
		print(current_scale)

func handle_grab()-> void:
	print("pick")
	freeze = true
	collidor.disabled = true
	
func handle_drop()-> void:
	print("drop")
	freeze = false
	collidor.disabled = false

extends RigidBody3D

class_name pickup_object

@onready var collidor: CollisionShape3D = $collidor

func handle_grab()-> void:
	print("pick")
	freeze = true
	collidor.disabled = true
	
func handle_drop()-> void:
	print("drop")
	freeze = false
	collidor.disabled = false

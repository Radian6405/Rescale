extends Node3D

class_name door

@onready var hinge: Node3D = $hinge

func open_door() -> void:
	hinge.rotation = Vector3(0,deg_to_rad(90),0)
	print("Open")

func close_door() -> void:
	hinge.rotation = Vector3.ZERO
	print("Close")
	

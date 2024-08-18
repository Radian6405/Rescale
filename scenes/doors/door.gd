extends Node3D

class_name door

@onready var hinge: Node3D = $hinge
@onready var init_pos: Vector3 = hinge.position
@onready var init_rot: Vector3 = hinge.rotation

@export var door_type: int = 0
@export var rot_angle: float = 90.0
@export var move_length: float = 1.5
# type 0 is rotating doors
# type 1 is sliding doors

func open_door() -> void:
	match door_type:
		0:
			hinge.rotation.y = init_rot.y + deg_to_rad(rot_angle)
		1:
			hinge.position.x = init_pos.x + move_length
	print("Open")

func close_door() -> void:
	match door_type:
		0:
			hinge.rotation.y = init_rot.y
		1:
			hinge.position.x = init_pos.x
	print("Close")
	

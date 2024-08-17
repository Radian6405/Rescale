extends Node3D

class_name jumpad

@export var jump_power := 10.0

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body is player:
		print(basis.y * jump_power)
		body.apply_jump_velocity(basis.y * jump_power)

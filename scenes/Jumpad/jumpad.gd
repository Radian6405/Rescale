extends StaticBody3D

class_name jumpad

var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")

@export var jump_height := 10.0
@export var path_dropoff_coefficient := 0.2
@export var path_length_multiplier := 2
@onready var path: Path3D = $path

var path_taken := Curve3D.new()

func _ready() -> void:
	var path_dropoff := (path_dropoff_coefficient * gravity * 0.01 * sqrt(basis.y.x * basis.y.x+basis.y.z * basis.y.z))
	for i in range(jump_height * path_length_multiplier):
		var new_loc := (basis.y * i - Vector3(0, path_dropoff * pow(i,3),0))
		path_taken.add_point(basis.inverse() * new_loc , Vector3.ZERO, Vector3.ZERO, i)

	path.curve = path_taken


func _on_area_3d_body_entered(body: Node3D) -> void:
	var req_vel = sqrt(2 * gravity * jump_height)
	if body is player:
		body.apply_jump_velocity(basis.y * req_vel)

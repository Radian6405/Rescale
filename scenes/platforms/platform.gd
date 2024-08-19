extends StaticBody3D

class_name platform

@onready var mass_label: Label3D = $MassLabel

@export var MASS_REQUIRED := 10
var current_mass := 0:
	set (value):
		current_mass = max(value, 0)
		print(current_mass)
		if current_mass >= MASS_REQUIRED:
			door_obj.open_door()
		else:
			door_obj.close_door()

@export var door_obj: door

func _ready() -> void:
	mass_label.text = "Required mass: " + str(MASS_REQUIRED)
	
func _process(delta: float) -> void:
	if current_mass < MASS_REQUIRED:
		mass_label.visible = true
		mass_label.text = "Required mass: " + str(MASS_REQUIRED - current_mass)
	else:
		mass_label.visible = false
func _on_area_3d_body_entered(body: Node3D) -> void:
	if body is pickup_object:
		current_mass += body.mass
		
		printt("enter:",body, current_mass)
		
	if body is player:
		current_mass += body.MASS
		print("player entered")

func _on_area_3d_body_exited(body: Node3D) -> void:
	if body is pickup_object:
		current_mass -= body.mass
		printt("exit:",body, current_mass)
		
	if body is player:
		current_mass -= body.MASS
		print("player exited")

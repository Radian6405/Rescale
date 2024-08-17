extends StaticBody3D

class_name button

var is_clicked := false

@export var door_obj: door
@onready var button_parent: Node3D = $ButtonParent

func button_click() -> void:
	if not is_clicked:
		door_obj.open_door()
		is_clicked = true
		button_parent.position.y -= 0.1

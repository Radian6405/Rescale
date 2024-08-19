extends Node3D

@onready var label_1: Label = $VBoxContainer2/Label1

func _ready() -> void:
	label_1.visible = false

func _on_tut_1_area_body_entered(body: Node3D) -> void:
	if body is player:
		label_1.visible = true
func _on_tut_1_area_body_exited(body: Node3D) -> void:
	if body is player:
		label_1.visible = false

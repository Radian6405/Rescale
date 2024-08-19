extends Node3D

@export var player_obj: player

@onready var label_1: Label = $VBoxContainer2/Label1
@onready var label_2: Label = $VBoxContainer2/Label2
@onready var label_3: Label = $VBoxContainer2/Label3
@onready var label_4: Label = $VBoxContainer2/Label4

func _ready() -> void:
	label_1.visible = false
	label_2.visible = false
	label_3.visible = false
	label_4.visible = false
	
func _process(delta: float) -> void:
	if player_obj.hand.get_child_count() > 0 && label_2.visible && !label_4.visible:
		label_2.visible = false
		label_3.visible = true
	if player_obj.hand.get_child_count() == 0 && label_3.visible && !label_4.visible:
		label_3.visible = false
		label_2.visible = true


func _on_tut_1_area_body_entered(body: Node3D) -> void:
	if body is player:
		label_1.visible = true
func _on_tut_1_area_body_exited(body: Node3D) -> void:
	if body is player:
		label_1.visible = false


func _on_tut_2_area_body_entered(body: Node3D) -> void:
	if body is player:
		label_2.visible = true
func _on_tut_2_area_body_exited(body: Node3D) -> void:
	if body is player:
		label_2.visible = false


func _on_tut_3_area_body_entered(body: Node3D) -> void:
	if body is player:
		label_4.visible = true
func _on_tut_3_area_body_exited(body: Node3D) -> void:
	if body is player:
		label_4.visible = false

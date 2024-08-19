extends Node3D

@onready var main_control: Control = $MainControl
@onready var level_control: Control = $LevelControl

@export_file("*.tscn") var level_1_1
@export_file("*.tscn") var level_1_2
@export_file("*.tscn") var level_1_3

func _ready() -> void:
	main_control.visible = true
	level_control.visible = false
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func _on_play_button_pressed() -> void:
	main_control.visible = false
	level_control.visible = true


func _on_options_button_pressed() -> void:
	pass # Replace with function body.


func _on_quit_button_pressed() -> void:
	get_tree().quit()


func _on_level_1_button_pressed() -> void:
	change_level(level_1_1)

func _on_level_2_button_pressed() -> void:
	change_level(level_1_2)

func _on_level_3_button_pressed() -> void:
	change_level(level_1_3)

func change_level(level) -> void:
	get_tree().change_scene_to_file(level)


func _on_back_button_pressed() -> void:
	main_control.visible = true
	level_control.visible = false

extends Control

@onready var player_obj: player = $".."

@export_file("*.tscn") var main_menu

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	visible = false
	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
			player_obj.set_physics_process(false)
			visible = true
		else:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
			player_obj.set_physics_process(true)
			visible = false
			


func _on_continue_button_pressed() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	player_obj.set_physics_process(true)
	visible = false

func _on_return_button_pressed() -> void:
	change_level(main_menu)
	
func change_level(level) -> void:
	get_tree().change_scene_to_file(level)

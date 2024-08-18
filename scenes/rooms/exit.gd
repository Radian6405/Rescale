extends CSGCombiner3D

@export_file("*.tscn") var file_path

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body is player:
		print("level finished")
		call_deferred("load_new_scene")
	
func load_new_scene() -> void:
		get_tree().change_scene_to_file(file_path) 

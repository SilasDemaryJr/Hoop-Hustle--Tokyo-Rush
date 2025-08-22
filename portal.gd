extends Area2D

@export var next_scene: String = "main_menu"

func _on_body_entered(body):
	if body.name == "Player":
		get_tree().change_scene_to_file("res://level_1.tscn")

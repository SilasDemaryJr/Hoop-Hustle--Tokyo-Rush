extends Control
@onready var main_buttons: VBoxContainer = $MainButtons
@onready var options: Panel = $Options


func _process(_delta):
	pass

func _ready():
	main_buttons.visible = true
	options.visible = false
	
	
func _on_start_pressed():
	get_tree().change_scene_to_file("res://level.tscn")


func _on_settings_pressed():
	main_buttons.visible = false
	options.visible = true

func _on_exit_pressed():
	get_tree().quit()


func _on_back_options_pressed() -> void:
	_ready()

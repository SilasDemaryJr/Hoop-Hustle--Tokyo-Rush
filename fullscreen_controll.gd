extends CheckButton


func _on_toggled(toggled_on: bool) -> void:
	if OS.get_name() != "Web":
		if toggled_on:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		else:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	else:
		print("Fullscreen mode is not supported in this context")
		

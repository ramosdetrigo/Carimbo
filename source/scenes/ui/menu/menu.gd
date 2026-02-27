extends HBoxContainer


func _ready() -> void:
	await get_tree().create_timer(0.5).timeout
	%ContinueButton.grab_focus()


func _disable_buttons() -> void:
	for button: Button in %ButtonsVbox.get_children():
		button.disabled = true


func _on_continue_button_pressed() -> void:
	_disable_buttons()


func _on_play_button_pressed() -> void:
	_disable_buttons()
	%PlayButton.burned.connect(func():
		SceneLoader.load_scene("uid://dbx0mdbod3dh8"))


func _on_config_button_pressed() -> void:
	_disable_buttons()


func _on_credits_button_pressed() -> void:
	_disable_buttons()


func _on_exit_button_pressed() -> void:
	_disable_buttons()
	%ExitButton.burned.connect(get_tree().quit)

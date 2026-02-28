extends Submenu


func _on_continue_button_pressed() -> void:
	_disable_buttons()


func _on_play_button_pressed() -> void:
	_disable_buttons()
	%PlayButton.burned.connect(func():
		SceneLoader.load_scene("uid://x7n822k4igmc")) # intro


func _on_config_button_pressed() -> void:
	_disable_buttons()
	change_menu.emit(Consts.MENUS["config"])


func _on_credits_button_pressed() -> void:
	_disable_buttons()
	change_menu.emit(Consts.MENUS["credits"])


func _on_exit_button_pressed() -> void:
	_disable_buttons()
	%ExitButton.burned.connect(get_tree().quit)

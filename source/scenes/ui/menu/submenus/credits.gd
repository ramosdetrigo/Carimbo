extends Submenu


func _on_back_button_pressed() -> void:
	change_menu.emit(Consts.MENUS["main"])

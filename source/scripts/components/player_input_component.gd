class_name PlayerInputComponent
extends InputComponent


func _unhandled_input(_event: InputEvent) -> void:
	var dir: Vector2 = Input.get_vector(
		&"move_left", &"move_right", &"move_fowards", &"move_backwards")
	set_horizontal_input_direction(dir)

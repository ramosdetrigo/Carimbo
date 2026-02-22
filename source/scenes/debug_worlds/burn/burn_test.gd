extends Node3D


func _on_burn_button_pressed() -> void:
	%Mario.trigger_burn_fx()


func _on_stamp_button_pressed() -> void:
	%Mario.stamp(preload("res://assets/tmp/carimbo.png"), Vector2(0.5, 0.5))


func _on_reset_button_pressed() -> void:
	%Mario.material_override.set_shader_parameter("burn_amount", 0.0)
	%Mario.stamp_viewport.render_target_clear_mode = SubViewport.CLEAR_MODE_ONCE
	%Mario.stamp_viewport.render_target_update_mode = SubViewport.UPDATE_ONCE

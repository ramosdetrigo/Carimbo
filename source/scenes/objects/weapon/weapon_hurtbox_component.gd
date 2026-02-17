class_name WeaponHurtboxComponent
extends HurtboxComponent

@export var animation_player: AnimationPlayer

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed(&"hit"):
		animation_player.play(&"hit")
		get_viewport().set_input_as_handled()

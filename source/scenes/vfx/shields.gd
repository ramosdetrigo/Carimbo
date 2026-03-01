extends Node3D

@export var gpu_particles_3d: GPUParticles3D
@export var animation_player: AnimationPlayer


func on_armor_changed(armor: float) -> void:
	if armor > 0.0:
		show()
		gpu_particles_3d.set_emitting(true)
		animation_player.play_backwards(&"scale_down")
		animation_player.play(&"rotate")
	else:
		shatter()


func shatter() -> void:
	gpu_particles_3d.emitting = true
	#gpu_particles_3d.reparent(get_tree().current_scene)
	#gpu_particles_3d.global_position = global_position
	animation_player.pause()
	animation_player.play("scale_down")
	await animation_player.animation_finished
	hide()

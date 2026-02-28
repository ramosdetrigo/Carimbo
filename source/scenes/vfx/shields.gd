extends Node3D

@export var gpu_particles_3d: GPUParticles3D
@export var animation_player: AnimationPlayer

func shatter() -> void:
	gpu_particles_3d.emitting = true
	gpu_particles_3d.reparent(get_tree().current_scene)
	gpu_particles_3d.global_position = global_position
	animation_player.pause()
	animation_player.play("scale_down")

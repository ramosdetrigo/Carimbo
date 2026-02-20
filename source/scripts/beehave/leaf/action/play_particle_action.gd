@tool
class_name PlayParticleAction
extends ActionLeaf

@export var particle_scene: PackedScene

func tick(actor: Node, _blackboard: Blackboard) -> int:
	var scene: Node = particle_scene.instantiate()
	if scene is not GPUParticles3D: return FAILURE
	var particle: GPUParticles3D = scene
	particle.set_emitting(true)
	actor.add_sibling(particle)
	if actor is Node3D: particle.set_global_position((actor as Node3D).global_position)
	particle.finished.connect(particle.queue_free)
	return SUCCESS

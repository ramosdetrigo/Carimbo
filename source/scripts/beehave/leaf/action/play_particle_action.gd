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
	particle.finished.connect(particle.queue_free)
	return SUCCESS

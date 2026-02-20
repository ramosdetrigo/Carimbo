@tool
class_name EvolveToAction
extends ActionLeaf

@export var entity_scene: PackedScene

func tick(actor: Node, _blackboard: Blackboard) -> int:
	if not entity_scene or actor is not Node3D: return FAILURE
	var new_entity: Node3D = entity_scene.instantiate()
	actor.add_sibling(new_entity)
	new_entity.global_position = (actor as Node3D).global_position
	actor.queue_free()
	return SUCCESS

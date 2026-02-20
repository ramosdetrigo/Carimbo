class_name AttackScene
extends Node3D

@export var attack_info: AttackInfo
@export_range(0.1, 100.0, 0.1, "or_greater", "or_less", "suffix:sec")
var lifetime: float = 0.5: set = _set_lifetime

@export var hurtbox_component: HurtboxComponent


func _ready() -> void:
	if not hurtbox_component: return
	hurtbox_component.hit.connect(destroy)
	if hurtbox_component.should_hit_bodys: hurtbox_component.body_hit.connect(destroy)
	hurtbox_component.attack_info = attack_info


func _grab_first_hurtbox_component() -> HurtboxComponent:
	var candidates: Array = get_children().filter(func(n: Node) -> bool: return n is HurtboxComponent)
	return candidates.pop_front()


func destroy() -> void:
	queue_free()


func _set_lifetime(value: float) -> void:
	lifetime = value
	if lifetime <= 0:
		destroy()

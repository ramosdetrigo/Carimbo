class_name AttackScene
extends Node3D

@export var attack_info: AttackInfo
@export_range(0.1, 100.0, 0.1, "or_greater", "or_less", "suffix:sec")
var lifetime: float = 0.5: set = _set_lifetime
@export var should_break_on_contact: bool = true
@export var hurtbox_component: HurtboxComponent


func _ready() -> void:
	if not hurtbox_component: return
	hurtbox_component.attack_info = attack_info
	if not should_break_on_contact: return
	hurtbox_component.hit.connect(destroy)
	if hurtbox_component.should_hit_bodys: hurtbox_component.body_hit.connect(destroy)


func _physics_process(delta: float) -> void:
	lifetime -= delta


func destroy() -> void:
	queue_free()


func _set_lifetime(value: float) -> void:
	lifetime = value
	if lifetime <= 0:
		destroy()

class_name AttackScene
extends Node3D

signal lifetime_depleted()

@export var attack_info: AttackInfo
@export var should_disappear: bool = true
@export_range(0.1, 100.0, 0.1, "or_greater", "or_less", "suffix:sec")
var lifetime: float = 0.5: set = _set_lifetime
@export var should_break_on_contact: bool = true
@export var hurtbox_component: HurtboxComponent
@export var particle: GPUParticles3D
@export var audio: AudioStreamPlayer3D

var swing_dir: Vector3:
	set(v): swing_dir = v; if hurtbox_component: hurtbox_component.launch_direction = swing_dir

func _ready() -> void:
	if not audio: audio = get_children().filter(func(c): return c is AudioStreamPlayer3D).front()
	if audio: audio.play()
	_handle_particle()
	_handle_hurtbox()


func _handle_particle() -> void:
	if not particle: particle = _get_particle()
	if not particle: return
	particle.set_emitting(true)
	if particle.one_shot: particle.finished.connect(particle.queue_free)
	else: lifetime_depleted.connect(particle.queue_free)
	particle.reparent.call_deferred(get_parent_node_3d())


func _handle_hurtbox() -> void:
	if not hurtbox_component: hurtbox_component = _get_hurtbox_component()
	if not hurtbox_component: return
	hurtbox_component.attack_info = attack_info
	if not should_break_on_contact: return
	hurtbox_component.hit.connect(destroy)
	hurtbox_component.body_hit.connect(destroy)


func _get_hurtbox_component() -> HurtboxComponent:
	var a: Array = get_children().filter(func(c): return c is HurtboxComponent)
	return null if a.is_empty() else a.front()


func _get_particle() -> GPUParticles3D:
	var a: Array = get_children().filter(func(c): return c is GPUParticles3D)
	return null if a.is_empty() else a.front()


func _physics_process(delta: float) -> void:
	if not should_disappear: return
	lifetime -= delta


func destroy() -> void:
	lifetime_depleted.emit()
	queue_free()


func _set_lifetime(value: float) -> void:
	lifetime = value
	if lifetime <= 0:
		destroy()

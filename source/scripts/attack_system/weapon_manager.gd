class_name WeaponManager
extends Node3D

signal rune_changed(rune: Rune)
signal runes_updated(runes: Array[Rune])
signal attack_melee()
signal attack_ranged()

@export var stats_component: StatsComponent
@export var cooldown_timer: Timer
@export var attack_spawn_offset: Vector3
@export var runes: Array[Rune] = []
@export var sub_runes: Array[Rune] = []

var current_rune: Rune:
	set(v): current_rune = v; rune_changed.emit(current_rune)
var current_type: int = 0

static var instance: WeaponManager

func _ready() -> void:
	if not instance: instance = self
	else: queue_free()
	runes_updated.emit.call_deferred(runes)
	select_rune.call_deferred(0)


func attack(shooting_dir: Vector3 = Vector3.UP) -> void:
	if not current_rune or not current_rune.attack_scene: return
	if not cooldown_timer.is_stopped(): return
	var attk: AttackScene = current_rune.attack_scene.instantiate()
	owner.add_sibling(attk)
	var pos: Vector3 = global_position + attack_spawn_offset
	if attk is not AttackProjectile: shooting_dir.y = 0.0; shooting_dir = shooting_dir.normalized()
	attk.look_at_from_position(pos, pos + shooting_dir)
	attk.swing_dir = shooting_dir
	(attack_ranged if attk is AttackProjectile else attack_melee).emit()
	cooldown_timer.start(current_rune.cooldown)
	if current_rune.is_flag_true(Rune.RuneFlags.LIFE_STEAL):
		stats_component.set_health_call(func(p: float) -> float: return p + attk.attack_info.damage / 2.0)
	if current_rune.is_flag_true(Rune.RuneFlags.ARMOR_PROVIDER):
		stats_component.set_armor(2)
	if current_rune in sub_runes:
		select_rune(current_type)


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed(&"rune_next"): select_rune(current_type + 1)
	elif event.is_action_pressed(&"rune_prev"): select_rune(current_type - 1)
	elif event.is_action_pressed(&"sub_rune"): select_sub_rune()


func select_rune(type: int) -> void:
	type = wrapi(type, 0, runes.size())
	current_type = type
	current_rune = runes.get(current_type)


func select_sub_rune() -> void:
	if current_type >= sub_runes.size(): select_rune(current_type); return
	current_rune = sub_runes.get(current_type)


func append_rune(rune: Rune) -> void:
	runes.append(rune)
	runes_updated.emit(runes)


func append_sub_rune(rune: Rune) -> void:
	sub_runes.append(rune)

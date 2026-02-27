class_name WeaponManager
extends Node3D

signal rune_changed(rune: Rune)
signal runes_updated(runes: Array[Rune])
signal attack_melee()
signal attack_ranged()

@export var cooldown_timer: Timer
@export var attack_spawn_offset: Vector3
@export var runes: Array[Rune] = []
var current_rune: Rune:
	set(v): current_rune = v; rune_changed.emit(current_rune)
var current_type: int = -1

func _ready() -> void:
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


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed(&"rune_next"): select_rune(current_type + 1)
	if event.is_action_pressed(&"rune_prev"): select_rune(current_type - 1)


func select_rune(type: int) -> void:
	type = wrapi(type, 0, runes.size())
	if current_type == type: return
	current_type = type
	current_rune = runes.get(current_type)

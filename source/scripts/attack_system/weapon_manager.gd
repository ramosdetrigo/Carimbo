class_name WeaponManager
extends Node3D

@export var input_component: InputComponent

@export var lifetime: float = 2.0
@export var damage: float = 1.0
@export var stamp_texture: Texture2D
@export var can_break_armor: bool = false
@export var ignores_armor: bool = false
@export_group("Ranged", "projectile_")
@export_custom(PROPERTY_HINT_GROUP_ENABLE, "") var projectile_is_ranged: bool = false
@export var projectile_scene: PackedScene
@export var projectile_speed: float = 5.0

var _info: AttackInfo

func _ready() -> void:
	_info = AttackInfo.new()
	_info.damage = damage
	_info.stamp_texture = stamp_texture
	_info.can_break_armor = can_break_armor
	_info.ignores_armor = ignores_armor


func shoot_projectile(shooting_dir: Vector3 = Vector3.ZERO) -> void:
	if not projectile_is_ranged or not projectile_scene or shooting_dir.is_zero_approx(): return
	var proj: AttackProjectile = projectile_scene.instantiate()
	proj.attack_info = _info
	proj.top_level = true
	proj.lifetime = lifetime
	proj.speed = projectile_speed
	get_tree().current_scene.add_child(proj)
	proj.global_position = global_position
	proj.look_at(global_position + shooting_dir)

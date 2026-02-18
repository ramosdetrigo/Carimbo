class_name DamageStampStrategy
extends StampStrategy

@export var damage_multiplier: float = 2.0

func apply_upgrade(weapon: AttackInfo) -> void:
	weapon.weapon_damage *= damage_multiplier
	weapon.current_stamp_texture = stamp_texture

func on_damaged(_target: CharacterBody3D) -> void:
	pass

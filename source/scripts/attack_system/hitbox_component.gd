class_name HitboxComponent
extends Area3D

signal damaged(attack: int)

@export var actor: StampableCharacter

func damage(info: WeaponInfo) -> void:
	if info.current_stamp_texture: actor.stampable_sprite.stamp_texture = info.current_stamp_texture
	damaged.emit(info.weapon_damage)


func on_actor(strategies: Array[StampStrategy]) -> void:
	for strategy: StampStrategy in strategies:
		strategy.on_damaged(actor)

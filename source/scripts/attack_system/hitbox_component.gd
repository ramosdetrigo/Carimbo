class_name HitboxComponent
extends Area3D

signal damaged(attack: AttackInfo)

@export var actor: StampableCharacter

func damage(info: AttackInfo) -> void:
	if info.stamp_texture:
		actor.stampable_sprite.stamp_texture = info.stamp_texture
	damaged.emit(info)


func on_actor(strategies: Array[StampStrategy]) -> void:
	for strategy: StampStrategy in strategies:
		strategy.on_damaged(actor)

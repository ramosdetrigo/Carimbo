class_name HitboxComponent
extends Area3D

signal damaged(attack: AttackInfo)

func damage(info: AttackInfo) -> void:
	damaged.emit(info)

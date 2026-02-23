class_name HitboxComponent
extends Area3D

@export_group("Auto Connect Signals")
@export_custom(PROPERTY_HINT_GROUP_ENABLE, "") var connect_signals_enable: bool
@export var stampable_sprite: ShadedAnimatedSprite3D

signal damaged(attack: AttackInfo)

func _ready() -> void:
	if connect_signals_enable and stampable_sprite:
		damaged.connect(stampable_sprite.on_hitbox_damaged)


func damage(info: AttackInfo) -> void:
	damaged.emit(info)

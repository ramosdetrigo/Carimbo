class_name HurtboxComponent
extends Area3D

signal hit()

@export var weapon_info: WeaponInfo
@export var weapon_strategies: Array[StampStrategy]


func _ready() -> void:
	area_entered.connect(_on_area_entered)


func _on_area_entered(area: Area3D) -> void:
	if area is HitboxComponent: _handle_damage(area as HitboxComponent)


func _handle_damage(hitbox: HitboxComponent) -> void:
	var info: WeaponInfo = weapon_info.duplicate(true)
	for strategy: StampStrategy in weapon_strategies:
		strategy.apply_upgrade(info)
	hitbox.damage(info)
	hitbox.on_actor(weapon_strategies)
	hit.emit()

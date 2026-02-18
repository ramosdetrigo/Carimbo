class_name HurtboxComponent
extends Area3D

signal hit()

@export var attack_info: AttackInfo
@export var attack_strategies: Array[StampStrategy]


func _ready() -> void:
	area_entered.connect(_on_area_entered)


func _on_area_entered(area: Area3D) -> void:
	if area is HitboxComponent: _handle_damage(area as HitboxComponent)


func _handle_damage(hitbox: HitboxComponent) -> void:
	var info: AttackInfo = attack_info.duplicate(true) if attack_info else AttackInfo.new()
	for strategy: StampStrategy in attack_strategies:
		strategy.apply_upgrade(info)
	hitbox.damage(info)
	hitbox.on_actor(attack_strategies)
	hit.emit()

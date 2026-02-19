class_name HurtboxComponent
extends Area3D

signal hit()

@export var attack_info: AttackInfo


func _ready() -> void:
	area_entered.connect(_on_area_entered)


func _on_area_entered(area: Area3D) -> void:
	if area is HitboxComponent: _handle_damage(area as HitboxComponent)


func _handle_damage(hitbox: HitboxComponent) -> void:
	var info: AttackInfo = attack_info if attack_info else AttackInfo.new()
	hitbox.damage(info)
	hit.emit()

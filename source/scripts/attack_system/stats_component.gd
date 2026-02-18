class_name StatsComponent
extends Node

enum DamageSuccess {
	MISS,
	HIT,
}

signal damaged(success: DamageSuccess)
signal health_changed(health: int)
signal armor_changed(armor: int)

@export var hitbox: HitboxComponent

@export var max_health: float = 1
@export var max_armor: float = 0

@onready var health: float = self.max_health
@onready var armor: float = self.max_armor

func _ready() -> void:
	if hitbox: hitbox.damaged.connect(on_damaged)


func on_damaged(attack: AttackInfo) -> void:
	if armor > 0 and not attack.can_break_armor:
		damaged.emit(DamageSuccess.MISS)
		return
	if armor > 0 and not attack.ignores_armor:
		armor -= attack.damage
		armor_changed.emit(armor)
		damaged.emit(DamageSuccess.HIT)
		return
	health -= attack.damage
	if health <= 0:
		health = 0
	health_changed.emit(health)
	damaged.emit(DamageSuccess.HIT)
	return

class_name StatsComponent
extends Node

signal missed()
signal health_changed(health: float)
signal armor_changed(armor: float)

@export var hitbox: HitboxComponent

@export var max_health: float = 1
@export var max_armor: float = 0

@onready var health: float = self.max_health
@onready var armor: float = self.max_armor

func _ready() -> void:
	if hitbox: hitbox.damaged.connect(on_damaged)


func on_damaged(attack: AttackInfo) -> void:
	if armor <= 0 or attack.ignores_armor:
		health = maxf(health - attack.damage, 0.0)
		health_changed.emit(health)
		return
	if not attack.can_break_armor:
		missed.emit()
		return
	armor = maxf(armor - attack.damage, 0.0)
	armor_changed.emit(armor)

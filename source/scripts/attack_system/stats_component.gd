class_name StatsComponent
extends Node

signal died()
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
	if health <= 0: return
	if armor <= 0 or attack.is_flag_true(AttackInfo.Flags.IGNORES_ARMOR):
		set_health(health - attack.damage); return
	if not attack.is_flag_true(AttackInfo.Flags.CAN_BREAK_ARMOR): return
	set_armor(armor - attack.damage)


func set_health(value: float) -> void:
	health = clampf(value, 0.0, self.max_health)
	health_changed.emit(health)
	if health <= 0: died.emit()


func set_armor(value: float) -> void:
	armor = clampf(value, 0.0, self.max_armor)
	armor_changed.emit(armor)


func kill() -> void:
	set_health(0)

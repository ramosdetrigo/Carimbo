class_name StatsComponent
extends Node

signal health_changed(health: int)
signal armor_changed(armor: int)

@export var hitbox: HitboxComponent

@export var max_health: int = 1
@export var max_armor: int = 0

@onready var health: int = self.max_health
@onready var armor: int = self.max_armor

func _ready() -> void:
	if hitbox: hitbox.damaged.connect(on_damaged)


func on_damaged(attack: int) -> void:
	if armor > 0:
		armor -= attack
		armor_changed.emit(armor)
		return
	health -= attack
	if health <= 0:
		health = 0
	health_changed.emit(health)

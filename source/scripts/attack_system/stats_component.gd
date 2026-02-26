class_name StatsComponent
extends Node

signal died()
signal health_changed(health: float)
signal health_lowered()
signal armor_changed(armor: float)

@export_range(1.0, 100.0, 0.1, "or_greater", "hide_control") var max_health: float = 1
@export_range(0.0, 100.0, 0.1, "or_greater", "hide_control") var max_armor: float = 0
@export var is_flying: bool = false

@export_group("Auto Connect Signals")
@export_custom(PROPERTY_HINT_GROUP_ENABLE, "") var connect_signals_enable: bool
@export var input_component: InputComponent
@export var hitbox_component: HitboxComponent
@export var beehave_tree: BeehaveTree

@onready var health: float = self.max_health
@onready var armor: float = self.max_armor

func _ready() -> void:
	if connect_signals_enable: _connect_signals()


func _connect_signals() -> void:
	if hitbox_component: hitbox_component.damaged.connect(on_damaged)
	if input_component: died.connect(input_component.stop_navigation)
	if owner is StampableCharacter:
		died.connect((owner as StampableCharacter).death)
		health_lowered.connect((owner as StampableCharacter).on_being_hit)
	if beehave_tree:
		died.connect(beehave_tree.disable)
		if input_component: beehave_tree.tree_disabled.connect(input_component.stop_navigation)


func on_damaged(attack: AttackInfo) -> void:
	if is_flying and not attack.is_flag_true(AttackInfo.Flags.CAN_HIT_FLYING): return
	if health <= 0: return
	if armor <= 0 or attack.is_flag_true(AttackInfo.Flags.IGNORES_ARMOR):
		set_health(health - attack.damage); return
	if not attack.is_flag_true(AttackInfo.Flags.CAN_BREAK_ARMOR): return
	set_armor(armor - attack.damage)


func set_health(value: float) -> void:
	var old: float = health
	health = maxf(value, 0.0)
	health_changed.emit(health)
	if health <= 0: died.emit()
	elif health < old: health_lowered.emit()


func set_armor(value: float) -> void:
	armor = maxf(value, 0.0)
	armor_changed.emit(armor)


## Accepts a Callable with the following format: [code]func(prev: float) -> float[/code]
func set_health_call(setter: Callable) -> void:
	set_health(setter.call(health))


## Accepts a Callable with the following format: [code]func(prev: float) -> float[/code]
func set_armor_call(setter: Callable) -> void:
	set_armor(setter.call(armor))


func kill() -> void:
	set_health(0)

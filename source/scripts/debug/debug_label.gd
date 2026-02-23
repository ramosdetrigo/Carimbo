@tool
class_name DebugLabel3D
extends Label3D

@export var stats_component: StatsComponent

var health: float = 0.0: set = set_health
var armor: float = 0.0: set = set_armor

func _init() -> void:
	set_text("FILHO DA PUTA")
	set_billboard_mode(BaseMaterial3D.BILLBOARD_ENABLED)
	set_editor_description("Uma label para debug que irá mostrar os valores de vida e armadura de um StatsComponent")


func _ready() -> void:
	if Engine.is_editor_hint() or not stats_component: return
	set_health(stats_component.health)
	set_armor(stats_component.armor)
	stats_component.armor_changed.connect(set_armor)
	stats_component.health_changed.connect(set_health)
	_update_text()


func set_health(value: float) -> void:
	health = value
	_update_text()


func set_armor(value: float) -> void:
	armor = value
	_update_text()


func _update_text() -> void:
	set_text("PV: %s\nPA: %s" % [health, armor])

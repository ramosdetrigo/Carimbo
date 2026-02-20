class_name StampableCharacter
extends CharacterBody3D

@export var stampable_sprite: ShadedAnimatedSprite3D
@export var stats_component: StatsComponent
@export var hitbox_component: HitboxComponent

func _ready() -> void:
	if stats_component: connect_death_signals(stats_component)
	if hitbox_component and stampable_sprite: connect_hit_signals(hitbox_component, stampable_sprite)


func death() -> void:
	if not stampable_sprite: return
	stampable_sprite.trigger_burn_fx()
	stampable_sprite.burned.connect(queue_free)


func connect_death_signals(stats: StatsComponent) -> void:
	if not stats.died.is_connected(self.death): stats.died.connect(self.death)


func connect_hit_signals(hit: HitboxComponent, sprite: ShadedAnimatedSprite3D) -> void:
	if not hit.damaged.is_connected(sprite.on_hitbox_damaged):
		hit.damaged.connect(sprite.on_hitbox_damaged)

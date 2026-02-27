class_name HurtboxComponent
extends Area3D

signal hit()
signal body_hit()

@export var launch_force: float = 15.0
var launch_direction: Vector3 = Vector3.FORWARD:
	set(v): launch_direction = v.normalized()

var attack_info: AttackInfo


func _ready() -> void:
	area_entered.connect(_on_area_entered)
	body_entered.connect(_on_body_entered)


func _on_area_entered(area: Area3D) -> void:
	if area is HitboxComponent: _handle_damage(area)
	if area is HurtboxComponent: area.owner.queue_free()


func _on_body_entered(body: Node3D) -> void:
	if body is FallingObject: _launch_falling_object(body)
	body_hit.emit()


func _launch_falling_object(body: FallingObject) -> void:
	body.apply_central_impulse(launch_direction * launch_force)


func _handle_damage(hitbox: HitboxComponent) -> void:
	var info: AttackInfo = attack_info if attack_info else AttackInfo.new()
	hitbox.damage(info)
	hit.emit()

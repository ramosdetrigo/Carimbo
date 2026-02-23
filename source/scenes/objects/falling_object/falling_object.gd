extends RigidBody3D

@export var attack_scene: PackedScene
@export var attack_spawn_offset: Vector3

@onready var lifetime_timer: Timer = $LifetimeTimer

func _ready() -> void:
	body_entered.connect(_on_body_entered)
	lifetime_timer.timeout.connect(_break)


func _on_body_entered(_body: Node) -> void:
	lifetime_timer.start()
	var attack: Node3D = attack_scene.instantiate()
	get_tree().current_scene.add_child(attack)
	attack.global_position = global_position + attack_spawn_offset


func _break() -> void:
	queue_free()

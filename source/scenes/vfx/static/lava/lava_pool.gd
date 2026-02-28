@tool
extends Area3D

@export var size: Vector3 = Vector3.ONE: set = set_size
@export var lava_mesh: MeshInstance3D
@export var hurtbox_collision: CollisionShape3D


func _ready() -> void:
	body_entered.connect(_on_body_entered)


func _on_body_entered(body: Node3D) -> void:
	if body is StampableCharacter: (body as StampableCharacter).death()


func set_size(v: Vector3) -> void:
	size = v
	if not Engine.is_editor_hint(): await ready
	if not hurtbox_collision or not lava_mesh: return
	(hurtbox_collision.shape as BoxShape3D).size = size
	(lava_mesh.mesh as PlaneMesh).size = Vector2(size.x, size.z)
	((lava_mesh.mesh as PlaneMesh).material as ShaderMaterial).set_shader_parameter("uv_scale",
		Vector2(size.x / 10, size.z / 10))

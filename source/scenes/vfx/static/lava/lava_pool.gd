@tool
extends FogVolume

@export var lava_height: float = 0.0:
	set(v): lava_height = v; lava_mesh.position.y = lava_height

@onready var collision: CollisionShape3D = %HurtboxCollision
@onready var lava_mesh: MeshInstance3D = $LavaMesh

func _ready() -> void:
	_setup(size)


func _set(property: StringName, value: Variant) -> bool:
	if property == "size":
		_setup(value)
	return false


func _setup(value: Vector3) -> void:
	if not collision or not lava_mesh: return
	collision.position = Vector3.ZERO
	var s: BoxShape3D = collision.shape
	s.size = value
	var m: PlaneMesh = lava_mesh.mesh
	m.size = Vector2(value.x, value.z)
	var mm: ShaderMaterial = m.material
	mm.set_shader_parameter("uv_scale", Vector2(value.x / 10.0, value.z / 10.0))

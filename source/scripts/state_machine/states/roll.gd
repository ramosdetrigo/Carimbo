class_name RollState
extends State

@export var idle_state: IdleState

var actor: CharacterController3D
var direction: Vector3
var timer: SceneTreeTimer

func enter(a: CharacterController3D) -> void:
	actor = a
	timer = get_tree().create_timer(0.3)
	direction = a.get_input_direction()


func exit() -> void:
	pass


func process(_delta: float) -> void:
	pass


func physics_process(_delta: float) -> void:
	actor.velocity = direction * 10.0
	if is_zero_approx(timer.time_left):
		transitioned.emit(self, idle_state)

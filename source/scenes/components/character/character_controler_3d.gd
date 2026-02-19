class_name CharacterController3D
extends StampableCharacter

@export var state_machine: StateMachine
@export var weapon: WeaponHurtboxComponent


func _ready() -> void:
	state_machine.initialize(self)

func _physics_process(_delta: float) -> void:
	_rotate_weapon_with_mouse()
	move_and_slide()


func _rotate_weapon_with_mouse() -> void:
	var screen_middle: float = get_viewport().get_visible_rect().size.x / 2.0
	var mouse_x: float = get_viewport().get_mouse_position().x
	var is_right: bool = mouse_x >= screen_middle
	if is_zero_approx(mouse_x): return
	weapon.look_at(weapon.global_position + Vector3(mouse_x if is_right else -mouse_x, 0.0, 0.0))

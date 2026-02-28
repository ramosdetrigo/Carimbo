@tool
class_name AnimatedCheckButton
extends CheckBox


@export var burn_on_press: bool = true

@export var tween_duration: float = 0.1

@export_group("Scale")
@export var scale_ease_type: Tween.EaseType = Tween.EASE_IN_OUT
@export var scale_trans_type: Tween.TransitionType = Tween.TRANS_LINEAR
@export var scale_target: Vector2 = Vector2(1.1, 1.1)
var scale_tween: Tween

@export_group("Rotation")
@export var rot_ease_type: Tween.EaseType = Tween.EASE_IN_OUT
@export var rot_trans_type: Tween.TransitionType = Tween.TRANS_LINEAR
@export var rot_target: Vector2 = Vector2(1.1, 1.1)
@export_range(0.0, 180.0) var rot_range: float = 90.0
var rotate_tween: Tween

func _ready() -> void:
	pivot_offset_ratio = Vector2(0.5, 0.5)
	focus_entered.connect(_mouse_entered)
	focus_exited.connect(_mouse_exited)
	mouse_entered.connect(_mouse_entered)
	mouse_exited.connect(_mouse_exited)

func _scale(target: Vector2) -> void:
	if scale_tween:
		scale_tween.kill()
	scale_tween = create_tween().set_ease(scale_ease_type).set_trans(scale_trans_type)
	scale_tween.tween_property(self, "scale", target, tween_duration)

func _rotate(target: float) -> void:
	if rotate_tween:
		rotate_tween.kill()
	rotate_tween = create_tween().set_ease(rot_ease_type).set_trans(rot_trans_type)
	rotate_tween.tween_property(self, "rotation", target, tween_duration)

func _reset() -> void:
	_scale(Vector2(1.0, 1.0))
	_rotate(0.0)

func _mouse_entered() -> void:
	if disabled: _reset(); return
	_scale(scale_target)
	_rotate(deg_to_rad(randf_range(-rot_range, rot_range)))

func _mouse_exited() -> void:
	if disabled: _reset(); return
	_reset()

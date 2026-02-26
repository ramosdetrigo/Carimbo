@tool
class_name RollState
extends State

@export var idle_state: IdleState
@export var move_component: MoveComponent
@export var input_component: InputComponent
@export var time: float = 0.5
@export var speed: float = 30.0

var _last_time: float
var _og_speed: float

func enter() -> void:
	animated_sprite.play(animation_name)
	_last_time = Time.get_ticks_msec()
	_og_speed = move_component.speed
	move_component.speed = speed



func exit() -> void:
	move_component.speed = _og_speed



func process(_delta: float) -> void:
	if Time.get_ticks_msec() < _last_time + time * 1000: return
	transitioned.emit(self, idle_state)


func physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed(&"roll"): _last_time = Time.get_ticks_msec()

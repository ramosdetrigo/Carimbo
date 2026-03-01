extends AttackScene

@export var animation_player: AnimationPlayer

func _ready() -> void:
	super._ready()
	animation_player.play(&"rise")


func destroy() -> void:
	animation_player.play_backwards(&"rise")
	await animation_player.animation_finished
	lifetime_depleted.emit()
	queue_free()


func _handle_particle() -> void:
	if not particle: particle = _get_particle()
	if not particle: return
	particle.set_emitting(true)

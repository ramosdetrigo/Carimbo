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

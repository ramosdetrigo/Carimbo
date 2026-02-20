@tool
class_name ShadedAnimatedSprite3D
extends AnimatedSprite3D

signal burned


var material: ShaderMaterial = material_override
@export var stamp_viewport: SubViewport


func _ready() -> void:
	frame_changed.connect(update_shader_anim)
	update_shader_anim()
	update_viewport_size()


## "Carimba" uma imagem em algum lugar aleatório da imagem
func stamp(image: Texture2D, size: Vector2 = Vector2(1.0, 1.0)) -> void:
	var vp_size = stamp_viewport.size

	# anda até 1/4 do tamanho do viewport pra algum lado
	var r = vp_size/4.0
	var pos_offset = Vector2(randi_range(-r.x, r.x), randi_range(-r.y, r.y))

	var pos = vp_size/2.0 + pos_offset
	stamp_offset(image, pos, size)


## Desenha uma imagem por cima do sprite = null
func stamp_offset(image: Texture2D, pos: Vector2, size: Vector2) -> void:
	var sprite = Sprite2D.new()
	sprite.position = pos
	sprite.scale = size
	sprite.texture = image
	stamp_viewport.add_child(sprite)

	# Faz o viewport atualizar no próximo frame
	stamp_viewport.render_target_update_mode = SubViewport.UPDATE_ONCE
	# Apaga o sprite depois do fim do próximo frame
	get_tree().process_frame.connect(func():
		get_tree().process_frame.connect(sprite.queue_free, CONNECT_ONE_SHOT),
	CONNECT_ONE_SHOT)

## Atualiza o tamanho do viewport de carimbos de acordo com a animação
func update_viewport_size() -> void:
	var max_x: int = 0
	var max_y: int = 0

	# Itera por cada frame de cada animação
	for anim in sprite_frames.get_animation_names():
		for f in sprite_frames.get_frame_count(anim):
			var tex = sprite_frames.get_frame_texture(anim, f)
			max_x = max(max_x, tex.get_width())
			max_y = max(max_y, tex.get_height())

	var size = Vector2(max_x, max_y)
	stamp_viewport.size = size


## Atualiza a texture no shader de acordo com a animação atual
func update_shader_anim() -> void:
	var curr_frame = sprite_frames.get_frame_texture(animation, frame)
	material.set_shader_parameter("texture_albedo", curr_frame)


## Executa o efeito de burn
func trigger_burn_fx(burn_time: float = 1.0) -> void:
	var burn_tween: Tween = create_tween()
	burn_tween.tween_method(
		func(b):
			material.set_shader_parameter("burn_amount", b)
	, 0.0, 1.0, burn_time)
	burn_tween.finished.connect(burned.emit)

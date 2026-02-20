// NOTE: Shader automatically converted from Godot Engine 4.6.stable's StandardMaterial3D.

shader_type spatial;
// render_mode blend_mix, depth_draw_opaque, cull_back, diffuse_burley, specular_schlick_ggx;

uniform float roughness : hint_range(0.0, 1.0);
uniform sampler2D texture_roughness : hint_roughness_r, filter_linear_mipmap, repeat_enable;
uniform float specular : hint_range(0.0, 1.0, 0.01);

uniform sampler2D texture_normal : hint_roughness_normal, filter_linear_mipmap, repeat_enable;
uniform float normal_scale : hint_range(-16.0, 16.0);

uniform vec4 albedo : source_color;
uniform sampler2D texture_albedo : source_color, filter_linear_mipmap, repeat_disable;

uniform sampler2D texture_carimbo : hint_default_transparent, source_color, filter_linear_mipmap, repeat_disable;
uniform float carimbo_glow_intensity: hint_range(0.0, 10.0, 0.1);

uniform sampler2D burn_texture;
uniform float burn_amount: hint_range(0.0, 1.0, 0.01);
uniform float burn_size: hint_range(0.0, 0.5, 0.001);
uniform float burn_smoothness: hint_range(0.0, 0.2, 0.001);
uniform vec3 burn_glow_color: source_color = vec3(1.0, 0.032, 0.0); 
uniform float burn_glow_intensity: hint_range(0.0, 10.0, 0.1);

void vertex() {
	// Billboard Mode: Y-Billboard
	MODELVIEW_MATRIX = VIEW_MATRIX * mat4(
			vec4(normalize(cross(vec3(0.0, 1.0, 0.0), MAIN_CAM_INV_VIEW_MATRIX[2].xyz)), 0.0),
			vec4(0.0, 1.0, 0.0, 0.0),
			vec4(normalize(cross(MAIN_CAM_INV_VIEW_MATRIX[0].xyz, vec3(0.0, 1.0, 0.0))), 0.0),
			MODEL_MATRIX[3]);

	// Billboard Keep Scale: Enabled
	MODELVIEW_MATRIX = MODELVIEW_MATRIX * mat4(
			vec4(length(MODEL_MATRIX[0].xyz), 0.0, 0.0, 0.0),
			vec4(0.0, length(MODEL_MATRIX[1].xyz), 0.0, 0.0),
			vec4(0.0, 0.0, length(MODEL_MATRIX[2].xyz), 0.0),
			vec4(0.0, 0.0, 0.0, 1.0));
	MODELVIEW_NORMAL_MATRIX = mat3(MODELVIEW_MATRIX);
}

void fragment() {
	// Normal & Roughness
	{
		SPECULAR = specular;
		// roughness
		vec4 roughness_texture_channel = vec4(1.0, 0.0, 0.0, 0.0);
		float roughness_tex = dot(texture(texture_roughness, UV), roughness_texture_channel);
		ROUGHNESS = roughness_tex * roughness;
		// normal
		NORMAL_MAP = texture(texture_normal, UV).rgb;
		NORMAL_MAP_DEPTH = normal_scale;
	}
	
	vec4 cor_og = texture(texture_albedo, UV) * albedo;
	vec4 cor_carimbo = texture(texture_carimbo, UV);
	// Overlay do carimbo na textura original
	vec3 cor_mix = mix(cor_og.rgb, cor_carimbo.rgb, cor_carimbo.a);
	
	// burn mask
	// essa "normalização" pelo burn_size impede que o sprite "queime" com
	// o burn_amount no 0, e garante que a animação de queima termine ao chegar no 1.0
	float burn_noise = texture(burn_texture, UV).r * (1.0 - burn_size) + burn_size;
	float burn_val = step(burn_amount, burn_noise);
	ALPHA = cor_og.a * burn_val;
	
	// glow mask
	float glow_mask = 0.0;
	float border_size = burn_amount + burn_size;
	glow_mask = 1.0 - smoothstep(
		border_size - burn_smoothness,
		border_size + burn_smoothness,
		burn_noise * (1.0 - burn_smoothness) + burn_smoothness
	);
	
	EMISSION = mix(vec3(0.0), burn_glow_color, glow_mask) * burn_glow_intensity
			 + cor_carimbo.rgb * carimbo_glow_intensity * (0.9 + sin(TIME * 5.0) * 0.1);
	ALBEDO = mix(cor_mix, vec3(0.0), glow_mask);
}

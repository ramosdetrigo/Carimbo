// NOTE: Shader automatically converted from Godot Engine 4.6.stable's StandardMaterial3D.

shader_type spatial;
// render_mode blend_mix, depth_draw_opaque, cull_back, diffuse_burley, specular_schlick_ggx;

uniform float roughness : hint_range(0.0, 1.0);
uniform sampler2D texture_metallic : hint_default_white, filter_linear_mipmap, repeat_enable;
uniform vec4 metallic_texture_channel;
uniform sampler2D texture_roughness : hint_roughness_r, filter_linear_mipmap, repeat_enable;
uniform float specular : hint_range(0.0, 1.0, 0.01);
uniform float metallic : hint_range(0.0, 1.0, 0.01);

uniform sampler2D texture_normal : hint_roughness_normal, filter_linear_mipmap, repeat_enable;
uniform float normal_scale : hint_range(-16.0, 16.0);

uniform vec4 albedo : source_color;
uniform sampler2D texture_albedo : source_color, filter_linear_mipmap, repeat_disable;

uniform sampler2D texture_carimbo : source_color, filter_linear_mipmap, repeat_disable;

uniform sampler2D burn_texture;
uniform float burn_min: hint_range(0.0, 1.0, 0.01);
uniform float burn_max_offset: hint_range(0.0, 1.0, 0.01);

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
	// metallic
	float metallic_tex = dot(texture(texture_metallic, UV), metallic_texture_channel);
	METALLIC = metallic_tex * metallic;
	SPECULAR = specular;
	// roughness
	vec4 roughness_texture_channel = vec4(1.0, 0.0, 0.0, 0.0);
	float roughness_tex = dot(texture(texture_roughness, UV), roughness_texture_channel);
	ROUGHNESS = roughness_tex * roughness;
	// normal
	NORMAL_MAP = texture(texture_normal, UV).rgb;
	NORMAL_MAP_DEPTH = normal_scale;
	
	// albedo
	vec4 cor_og = texture(texture_albedo, UV);
	vec4 cor_carimbo = texture(texture_carimbo, UV);
	// Overlay do carimbo na textura original
	ALBEDO = mix(cor_og.rgb, cor_carimbo.rgb, cor_carimbo.a) * albedo.rgb;
	
	// burn
	vec4 burn_tex = texture(burn_texture, UV);
	float burn_max = burn_min + burn_max_offset;
	float burn_val = smoothstep(burn_min, burn_max, burn_tex.r);
	
	ALPHA *= albedo.a * cor_og.a * burn_val;
}

shader_type spatial;

uniform sampler2D displacement_map: repeat_enable;
uniform sampler2D symbol;
uniform float glow_strength: hint_range(0.0, 10.0, 0.1) = 2.0;
uniform float glow_oscillation: hint_range(0.0, 1.0, 0.1) = 0.0;
uniform float displacement_strength: hint_range(0.0, 1.0, 0.01) = 0.1;
uniform vec3 displacement_vector = vec3(0.0);
uniform float displacement_speed: hint_range(0.0, 10.0, 0.1) = 1.0;
uniform vec2 uv_scale = vec2(1.0, 1.0);
uniform vec2 uv_offset = vec2(0.0, 0.0);

const float MAX_R = sqrt(2.0)/2.0;
void vertex() {
	vec2 cuv = UV - vec2(0.5, 0.5);
	float r = sqrt(cuv.x*cuv.x + cuv.y*cuv.y) / MAX_R; // normalized radius
	vec2 ruv = vec2(r);
	vec2 uv_mod = ruv * uv_scale - uv_offset * TIME * displacement_speed;
	
	float displacement = texture(displacement_map, uv_mod).r;
	VERTEX += NORMAL * displacement * displacement_strength;
	VERTEX += displacement_vector * (displacement * 2.0 - 1.0) * displacement_strength;
}

void fragment() {
	vec4 color = texture(symbol, UV);
	ALBEDO = color.rgb;
	ALPHA = color.a;
	
	vec2 cuv = UV - vec2(0.5, 0.5);
	float r = sqrt(cuv.x*cuv.x + cuv.y*cuv.y) / MAX_R; // normalized radius
	vec2 ruv = vec2(r);
	vec2 uv_mod = ruv * uv_scale - uv_offset * TIME * displacement_speed;
	
	float mask = texture(displacement_map, uv_mod).r;
	float glow = glow_strength * mask;
	glow += glow_oscillation * sin(TIME * 2.0) * glow;
	EMISSION = color.rgb * glow;
}

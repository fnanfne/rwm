shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE_OLD : hint_screen_texture, filter_linear_mipmap;
uniform sampler2D distortionTexture;

void fragment() {
	//vec2 distortedUV = SCREEN_UV + texture(TEXTURE, UV).r * 0.1;
	vec2 distortedUV = SCREEN_UV + texture(distortionTexture, UV).r * 0.1;
	//vec4 screenColor = texture(SCREEN_TEXTURE, SCREEN_UV);
	vec4 screenColor = texture(SCREEN_TEXTURE_OLD, distortedUV);
	COLOR = screenColor;
}

shader_type canvas_item;

const vec4 color1 = vec4(1.0, 1.0, 1.0, 1.0);

void fragment() {
	float time = sin(TIME*1.0);
	
	if(time < 0.0) {
		time = -time;
	}
	vec4 pixelColor = texture(TEXTURE, UV * 1.0);
	COLOR = (pixelColor * color1);
}

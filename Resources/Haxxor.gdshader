shader_type canvas_item;

uniform vec4 color : source_color;
uniform float flashState : hint_range(0,1) = 0.5;

void fragment() {
	vec4 pixelColor = texture(TEXTURE, UV);
	//float brightness = (pixelColor.r + pixelColor.g + pixelColor.b) / 3.0; // FOR GRAYSCALE
	//vec4 grayScale = vec4(brightness, brightness, brightness, pixelColor.a); // FOR GRAYSCALE
	//COLOR = pixelColor; // FOR GRAYSCALE?
	COLOR = mix(pixelColor, color, flashState);
	COLOR.a *= pixelColor.a;
}

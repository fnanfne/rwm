shader_type canvas_item;

uniform float speed = 1.0;
uniform float frequency = 10.0;
uniform float amplitude = 0.1;
uniform float alpha = 0.5;

void fragment() {
    vec2 uv = SCREEN_UV;
    float time = TIME * speed;

    float wave1 = sin(uv.x * frequency + time) * amplitude;
    float wave2 = cos(uv.y * frequency + time) * amplitude;
    uv += wave1 + wave2;

    vec3 color1 = vec3(0.5 + 0.5 * sin(time), 0.5 + 0.5 * cos(time), 0.5 - 0.5 * sin(time));
    vec3 color2 = vec3(0.5 - 0.5 * cos(time), 0.5 + 0.5 * sin(time), 0.5 + 0.5 * cos(time));
    vec3 gradient_color = mix(color1, color2, uv.y);

    // Set alpha (transparency) value
    //float alpha = 0.5; // Adjust the alpha value as needed

    // Output the modified color with transparency
    COLOR = vec4(gradient_color, alpha);
}

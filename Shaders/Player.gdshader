shader_type canvas_item;
render_mode blend_add;
const float PI = 3.1416;

void fragment(){
	COLOR = texture(TEXTURE, UV);
	vec2 coord = UV;
	if (COLOR.a > 0. && COLOR.r > 0. && COLOR.g > 0. && COLOR.b >0.){
	}
	coord.y -= 0.25*coord.x*coord.x*sin(100.*coord.x*coord.x*coord.x - TIME*10.);
	COLOR = texture(TEXTURE, coord);		
}
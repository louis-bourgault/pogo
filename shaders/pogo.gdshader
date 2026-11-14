shader_type canvas_item;


uniform float compression;
void vertex() {
	VERTEX.x+=0.3*compression*cos(50.0*TIME);
	
	// Called for every vertex the material is visible on.
}

void fragment() {
	
	vec4 k = texture(TEXTURE, UV);
	COLOR = k*vec4(1.0+compression, 1.0, 1.0, 1.0);
	// Called for every pixel the material is visible on.
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}

shader_type canvas_item;

void vertex() {
}
vec2 ran(vec2 uv) {
    uv *= vec2(dot(uv, vec2(127.1, 311.7)), dot(uv, vec2(227.1, 521.7)));
    float f = fract(tan(cos(uv.x) * 123.6) * 3533.3) * fract(tan(cos(uv.y) * 123.6) * 3533.3);
    return 1.0 - vec2(f, f); // Matching vec2 evaluation profile from original source
}

// Custom function matching your 'pt' logic
vec2 pt(vec2 id, float t) {
    return sin(t * (ran(id + 0.5) - 0.5) + ran(id - 20.1) * 8.0) * 0.5;
}

void fragment() {
	
	float size = 30.0;
	vec3 col1 = vec3(0.757, 0.161, 0.180);
	vec3 col2 = vec3(0.945, 0.827, 0.008);
	
    float t = TIME * 2.0;
    
    // Calculate resolution-adjusted aspect-ratio UV coordinates
    // In Godot, 1.0 / SCREEN_PIXEL_SIZE yields the viewport resolution
    vec2 resolution = 1.0 / SCREEN_PIXEL_SIZE;
    vec2 uv = (FRAGCOORD.xy - 0.5 * resolution) / resolution.x;
    
    vec2 off = TIME / vec2(50.0, 30.0);
    uv += off;
    uv *= size;
    
    vec2 gv = fract(uv) - 0.5;
    vec2 id = floor(uv);
    
    float mindist = 1e9;
    vec2 vorv = vec2(0.0);
    
    // Voronoi loop over neighboring grid cells
    for(float i = -1.0; i <= 1.0; i++) {
        for(float j = -1.0; j <= 1.0; j++) { 
            vec2 offv = vec2(i, j);
            float dist = length(gv + pt(id + offv, t) - offv);
            if(dist < mindist){
                mindist = dist;
                vorv = (id + pt(id + offv, t) + offv) / size - off;
            }
        }
    }
    
    // Mix the two target vector color definitions based on dynamic coordinates
    vec3 col = mix(col1, col2, clamp(vorv.x * 2.2 + vorv.y, -1.0, 1.0) * 0.5 + 0.5);
    COLOR = vec4(col, 1.0);
		
}

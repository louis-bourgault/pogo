extends Sprite2D

@export var uppertex :Texture2D
@export var lowertex :Texture2D
@export var compression: float
const shader = preload("res://pogo.gdshader")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var override_material = ShaderMaterial.new()
	override_material.shader = shader
	material = override_material
	var mat = material as ShaderMaterial
	if mat:
		mat.set_shader_parameter("compression", compression)            # Passes a float

	uppertex = ImageTexture.create_from_image(uppertex.get_image())
	lowertex = ImageTexture.create_from_image(lowertex.get_image())

	pass # Replace with function body.
func _on_h_slider_value_changed(value: float) -> void:
	compression = value

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	var canvas_tex = DrawableTexture2D.new()
	canvas_tex.setup(11, 22, DrawableTexture2D.DRAWABLE_FORMAT_RGBA8, Color(0, 0, 0, 0))
	canvas_tex.blit_rect(Rect2i(4,15,3,7), lowertex)
	canvas_tex.blit_rect(Rect2(0,compression*5,11,15), uppertex)
	var mat = material as ShaderMaterial
	if mat:
		mat.set_shader_parameter("compression", compression)            # Passes a float



	texture=canvas_tex

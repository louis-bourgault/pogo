extends Area2D

var texture = preload("res://sprites/flag_up.png")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func flagup() -> void:
	print('we got the checkpoint')
	$Sprite2D.texture = texture

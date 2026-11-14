extends Node

@export var button: Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if button.triggered == true:
		$TileMapLayer.collision_enabled = false
		$TileMapLayer.modulate.a = 0.2
	else:
		$TileMapLayer.collision_enabled = true
		$TileMapLayer.modulate.a = 1

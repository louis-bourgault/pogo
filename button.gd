extends Area2D

var imgTriggered = preload("res://sprites/buttonpressed.png")
var imgUntriggered = preload('res://sprites/buttonunpressed.png')
var triggered = false
# Called when the node enters the scene tree for the first time.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	if triggered:
		print('untriggering')
		$Sprite2D.texture = imgUntriggered
		triggered = false
	else:
		$Sprite2D.texture = imgTriggered
		triggered = true

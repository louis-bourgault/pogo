extends CharacterBody2D

const trampvelocity = 1300

const ANGLE_CHANGE_SPEED: float = 60
const SPRING_COMPRESSION_SPEED = 30
const max_rot = 70

var spring_compression: float = 0 #in %
var max_compression: float = 10
var spring_angle: float = 0
var sendoff_vel: float  = 10000
var checkpoint: Node2D = null
var kill_velocity: float = 10000000000

var grounded: bool = false
var pivot_around: Vector2
var spring_pressed_before = false

func _ready() -> void:
	checkpoint = %spawn
	
func _physics_process(delta: float) -> void:
	
	
	
	# Add the gravity.
	if not grounded:
		velocity += get_gravity() * delta
		
	if $groundFinder.is_colliding() and not grounded:
		if velocity.y <= 0:
			print("we shouldn't be doing this")
		else:
			grounded = true
			var hit_point = $groundFinder.get_collision_point()
			pivot_around = hit_point
			$stickpivot.global_position = Vector2(hit_point.x, hit_point.y)
			velocity.x = 0
			velocity.y = 0
			#$stickpivot.rotation = 0
			#$stickpivot/upper.position.y = 100
			#spring_angle = 0
			spring_compression = 0
		
	if Input.is_action_just_pressed("cp"):
		global_position = checkpoint.global_position

	# Handle spring.
	
	if grounded:
		if Input.is_action_pressed("down"):
			spring_compression += 1 * SPRING_COMPRESSION_SPEED * delta
			if spring_compression > max_compression:
				spring_compression = max_compression
			#print('we changed the compression to', spring_compression)
			spring_pressed_before = true
		elif spring_pressed_before == true:
			#we lift off now
			print('sending off')
			var launch_direction = Vector2(
				sin(deg_to_rad(spring_angle)),
				-cos(deg_to_rad(spring_angle))
			)
			grounded = false
			spring_pressed_before = false

			velocity = launch_direction * sendoff_vel * (spring_compression / 100.0)
			spring_compression = 0
		
	var direction := Input.get_axis("left", "right")
	
	if direction:
		var new_angle = spring_angle + direction * delta * ANGLE_CHANGE_SPEED
		if abs(new_angle) <= max_rot:
			spring_angle = new_angle
	
	#place everything at the right position
	$stickpivot.rotation_degrees = spring_angle
	$stickpivot/Sprite2D.compression = spring_compression*0.1

	move_and_slide()





func _on_killbox_body_entered(body: Node2D) -> void:
	print('kill')
	global_position = checkpoint.global_position
	pass # Replace with function body.

func _on_checkpoint_finder_area_entered(area: Area2D) -> void:
	checkpoint = area
	if checkpoint.flagup:
		checkpoint.flagup()
	pass # Replace with function body.

func _on_bodykillbox_body_entered(body: Node2D) -> void:
	
	if velocity.length()>kill_velocity:
		global_position = checkpoint.global_position
		print('kill')
	pass




func _on_tramp_body_entered(body: Node2D) -> void:
	velocity.y -= trampvelocity



func _on_trampleft_body_entered(body: Node2D) -> void:
	velocity.x += 0.7 * trampvelocity
	velocity.y -= 0.7 * trampvelocity
	pass # Replace with function body.




func _on_trampright_body_entered(body: Node2D) -> void:
	velocity.x -= 0.7 * trampvelocity
	velocity.y -= 0.7 * trampvelocity
	pass # Replace with function body.

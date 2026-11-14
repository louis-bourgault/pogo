extends CharacterBody2D

const ANGLE_CHANGE_SPEED: float = 20
const SPRING_COMPRESSION_SPEED = 30

var spring_compression: float = 0 #in %
var spring_length: float = 50
var spring_angle: float = 0
var sendoff_vel: float  = 10000


var grounded: bool = false
var pivot_around: Vector2
var spring_pressed_before = false

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	if $groundFinder.is_colliding() and not grounded:
		grounded = true
		var hit_point = $groundFinder.get_collision_point()
		pivot_around = hit_point
		$stickpivot.global_position = Vector2(hit_point.x, hit_point.y)
		velocity.x = 0
		velocity.y = 0
		$stickpivot.rotation = 0
		$stickpivot/upper.position.y = 100
		spring_angle = 0
		spring_compression = 0
		
		

	# Handle spring.
	
	if is_on_floor():
		if Input.is_action_pressed("down"):
			spring_compression += 1 * SPRING_COMPRESSION_SPEED * delta
			if spring_compression > spring_length:
				spring_compression = spring_length
			print('we changed the compression to', spring_compression)
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
		
	var direction := Input.get_axis("left", "right")
	if direction:
		spring_angle += direction * delta * ANGLE_CHANGE_SPEED
		print('angle is', spring_angle)
	
	#place everything at the right position
	$stickpivot.rotation_degrees = spring_angle
	$stickpivot/upper.position.y = -(100-spring_compression)

	move_and_slide()

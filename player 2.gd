extends KinematicBody2D

export var move_speed = 150.0

var velocity := Vector2.ZERO

var jump_height = 70
var jump_time_to_peak = 0.4
var jump_time_to_descent = 0.4

onready var jump_velocity : float = ((2.0 * jump_height) / jump_time_to_peak) * -1.0
onready var jump_gravity : float = ((-2.0 * jump_height) / (jump_time_to_peak * jump_time_to_peak)) * -1.0
onready var fall_gravity : float = ((-2.0 * jump_height) / (jump_time_to_descent * jump_time_to_descent)) * -1.0

var jump_timer : float
var jumping : bool
var direction : float
var bounce : bool

func _physics_process(delta):
	direction = get_input_velocity()
	velocity.y += get_gravity() * delta
	velocity.x =  direction * move_speed
	
	if bounce == true:
			move_speed = 100.0
	else:
		move_speed = 150.0
	
	if is_on_ceiling():
		jumping = false
		jump_timer=0
	
	if jump_timer>0.3:
		jump_timer=0.3
		
	if is_on_wall() :
		if bounce == false:
			direction = -direction
			bounce = true
		else:
			jumping = false
		
	if is_on_floor():
		bounce = false
	
	if not is_on_floor():
		jump_timer-=delta
		velocity.x += direction
		
		
		
		
	
	if (Input.is_action_just_released("ui_up") or jump_timer==0.3) and is_on_floor():
			jumping = true
			
	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		jump_timer=0
	if Input.is_action_pressed("ui_up") and is_on_floor() :
		velocity.x=0
		jump_timer += delta
	
			
	#if Input.is_action_just_released("up") and is_on_floor():
	if jumping == true and jump_timer>0:
		jump()
	else:
		jumping=false
		
	if velocity.x == 0:
		$AnimationTree.get("parameters/playback").travel("default")
	else:
		$AnimationTree.get("parameters/playback").travel("walk")
		$AnimationTree.set("parameters/default/blend_position", velocity)
		$AnimationTree.set("parameters/walk/blend_position", velocity)
	
	velocity = move_and_slide(velocity, Vector2.UP)

func get_gravity() -> float:
	return jump_gravity if velocity.y < 0.0 else fall_gravity

func jump():
	velocity.y = jump_velocity

func get_input_velocity() -> float:
	var horizontal := 0.0
	
	if Input.is_action_pressed("ui_left") and is_on_floor():
		horizontal -= 1.0
		direction = 1.0
	if Input.is_action_pressed("ui_right") and is_on_floor():
		horizontal += 1.0
		direction = 1.0
	
	if is_on_floor():
		return horizontal
	else:
		return direction
		
	

extends KinematicBody2D

const GRAVITY = Vector2(0, 1000)
const FLOOR_NORMAL = Vector2(0,-1)
const SLOPE_FRICTION = 20
const MOVEMENT_SPEED = 400
const ACCELRATION = 1
const JUMP_FORCE = 800

var can_jump = false

var velocity = Vector2()

func _ready():
	set_fixed_process(true)

func _fixed_process(delta):
	velocity += GRAVITY * delta
	move_and_slide(velocity, FLOOR_NORMAL, SLOPE_FRICTION)
	can_jump = is_move_and_slide_on_floor()
	
	var movement=0
	if(Input.is_action_pressed("ui_left")):
		movement -= 1
	if(Input.is_action_pressed("ui_right")):
		movement += 1
	
	if(can_jump && Input.is_action_pressed("ui_up")):
		velocity.y -= JUMP_FORCE
		can_jump = false
	
	movement *= MOVEMENT_SPEED
	
	velocity.x = lerp(velocity.x, movement, ACCELRATION)
	
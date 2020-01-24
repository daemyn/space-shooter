extends KinematicBody2D

export (int) var SPEED = 200

var velocity = Vector2(0, 0)
var anim_direction = 'idle'
var screen_size
var h_limits
var v_limits

onready var ship_size = $Sprite.get_rect().size 
onready var tilt = get_node("TiltAnimation")

func inputs_loop():
	var LEFT = Input.is_action_pressed("ui_left")
	var RIGHT = Input.is_action_pressed("ui_right")
	var UP = Input.is_action_pressed("ui_up")
	var DOWN = Input.is_action_pressed("ui_down")
	velocity.x = -int(LEFT) + int(RIGHT)
	velocity.y = -int(UP) + int(DOWN)

func movement_loop():
	var motion = velocity.normalized() * SPEED
	move_and_slide(motion, Vector2(0, 0))

func set_anim(animation):
	if anim_direction != animation and animation == 'idle':
		tilt.play(animation)
		anim_direction = animation
	elif anim_direction != animation:
		tilt.play(animation + '1')
		tilt.queue(animation + '2') 
		anim_direction = animation

func anim_loop():
	print(tilt.current_animation)
	if velocity.x > 0:
		set_anim('right')
	if velocity.x < 0:
		set_anim('left')
	if velocity.x == 0:
		set_anim('idle')

func _ready():
	# Called when the node enters the scene tree for the first time.
	screen_size = get_viewport_rect().size
	self.global_scale.x = 4
	self.global_scale.y = 4
	h_limits = Vector2(
		ship_size.x / 2 * global_scale.x,
		screen_size.x - (ship_size.x / 2) * global_scale.x
	)
	v_limits = Vector2(
		ship_size.y / 2 * global_scale.y, 
		screen_size.y - (ship_size.y / 2) * global_scale.y
	)

func _physics_process(delta):
	# Called every frame. 'delta' is the elapsed time since the previous frame.
	inputs_loop()
	movement_loop()
	anim_loop()
	position += velocity * delta
	position.x = clamp(position.x, h_limits.x, h_limits.y)
	position.y = clamp(position.y, v_limits.x, v_limits.y)

	
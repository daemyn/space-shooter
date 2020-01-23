extends KinematicBody2D

export (int) var speed = 200
var velocity = Vector2()
var screen_size
var h_limits
var v_limits

onready var ship_size = $Sprite.get_rect().size 

func get_input():
	velocity = Vector2()
	if Input.is_action_pressed('ui_right'):
		velocity.x += 1
	if Input.is_action_pressed('ui_left'):
		velocity.x -= 1
	if Input.is_action_pressed('ui_down'):
		velocity.y += 1
	if Input.is_action_pressed('ui_up'):
		velocity.y -= 1
	velocity = velocity.normalized() * speed
	
func _ready():
	# Called when the node enters the scene tree for the first time.
	screen_size = get_viewport_rect().size
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
	get_input()
	velocity = move_and_slide(velocity)
	position += velocity * delta
	position.x = clamp(position.x, h_limits.x, h_limits.y)
	position.y = clamp(position.y, v_limits.x, v_limits.y)

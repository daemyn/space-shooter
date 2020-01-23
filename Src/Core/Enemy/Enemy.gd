extends Area2D

var Rocket = preload("res://Src/Core/Rocket/Rocket.tscn")

var extents_min = Vector2()
var extents_max = Vector2()

var last_rocket = 0

var speed = 64
export var move_dir = 1

onready var level_scene = get_owner()

onready var ship_size = $Sprite.get_rect().size
onready var level_size = get_viewport_rect().size

var type = "ship"

func _ready():
    extents_min = Vector2(ship_size.x / 2 * global_scale.x, 0)
    extents_max = Vector2(level_size.x - (ship_size.x / 2 * global_scale.x), 0)

func _input(event):
    if Input.is_action_just_pressed("ui_accept"):
        _glow()

func _physics_process(delta):
    position.x += move_dir * speed * delta
    if position.x <= extents_min.x or position.x >= extents_max.x:
        move_dir *= -1
    last_rocket += delta
    if last_rocket > 1:
        _rocket()
        last_rocket = 0

func _glow():
    $Tween.interpolate_property($Sprite, 'modulate',
        Color(1, 1, 1, 1), Color(10, 10, 10, 1), 0.1,
        Tween.TRANS_QUAD, Tween.EASE_OUT)
    $Tween.interpolate_property($Sprite, 'modulate',
        Color(10, 10, 10, 1), Color(1, 1, 1, 1), 0.1,
        Tween.TRANS_QUAD, Tween.EASE_OUT, 0.1)
    $Tween.interpolate_property($Sprite, 'modulate',
        Color(1, 1, 1, 1), Color(10, 10, 10, 1), 0.1,
        Tween.TRANS_QUAD, Tween.EASE_OUT, 0.2)
    $Tween.interpolate_property($Sprite, 'modulate',
        Color(10, 10, 10, 1), Color(1, 1, 1, 1), 0.1,
        Tween.TRANS_QUAD, Tween.EASE_OUT, 0.3)
    $Tween.start()


func _on_Enemy_area_shape_entered(area_id, area, area_shape, self_shape):
    if area.get("type") and area.type == "ship":
        move_dir *= -1

func _rocket():
    var r = Rocket.instance()
    r.global_position = Vector2(global_position.x, global_position.y + ship_size.y / 2)
    level_scene.add_child(r)

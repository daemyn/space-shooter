extends Area2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var speed = 160

# Called when the node enters the scene tree for the first time.
func _ready():
    pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    position.y += speed * delta
    pass


func _on_VisibilityNotifier2D_screen_exited():
    print("removed")
    queue_free()
    pass # Replace with function body.

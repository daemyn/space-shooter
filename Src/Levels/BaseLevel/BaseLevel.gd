extends Node2D

var scroll = Vector2(0,100)

func _ready():
    pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    $ParallaxBackground.scroll_offset.y += scroll.y * delta
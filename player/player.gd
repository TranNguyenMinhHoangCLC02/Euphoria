extends CharacterBody2D

var speed = 300
var click_position = Vector2()
var target_position = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	click_position = position

func _physics_process(delta) -> void:
	if Input.is_action_just_pressed("left_click") == true:
		click_position = get_global_mouse_position()
	
	if position.distance_to(click_position) > 3:
		target_position = (click_position - position).normalized()
		velocity = target_position * speed
		move_and_slide()

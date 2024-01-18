extends CharacterBody2D

@onready var animated_sprite_2d = $AnimatedSprite2D

var speed = 300
var click_position = Vector2()
var target_position = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	click_position = position

func _physics_process(_delta) -> void:
	if Input.is_action_just_pressed("left_click") == true:
		click_position = get_global_mouse_position()
	if position.distance_to(click_position) > 3:
		target_position = (click_position - position).normalized()
		var curr_speed = speed
		velocity = target_position * curr_speed
		if target_position.x < 0:
			animated_sprite_2d.flip_h = true
		else:
			animated_sprite_2d.flip_h = false
		animated_sprite_2d.play("walk")
		move_and_slide()

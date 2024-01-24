extends CharacterBody2D

@onready var animated_sprite_2d = $AnimatedSprite2D

var speed = 300
var click_position = Vector2()
var target_position = Vector2()
var isRunMode = false

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
		#animated_sprite_2d.play("walk")
		_toggle_run()
		move_and_slide()

func _toggle_run() -> void:
	if Input.is_key_pressed(KEY_CTRL):
		isRunMode = true
	else:
		isRunMode = false
	if isRunMode:
		speed = 800
		animated_sprite_2d.play("run", 2)
	else:
		speed = 300
		animated_sprite_2d.play("walk")


func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			click_position = get_global_mouse_position()
	elif event is InputEventKey and event.scancode == KEY_CTRL:
		isRunMode = event.pressed
		_toggle_run()
		

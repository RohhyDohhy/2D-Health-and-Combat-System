extends CharacterBody2D

@export var speed: float = 400.0
@export var acceleration: float = 7.0

var player_input: Vector2 = Vector2.ZERO

func _process(delta: float) -> void:
	_handle_input()
	_handle_movement(delta)
	
	move_and_slide()


func _handle_input() -> void:
	player_input.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	player_input.y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")

	player_input = player_input.normalized() if player_input.length() > 1 else player_input


func _handle_movement(delta: float) -> void:
	velocity = lerp(velocity, player_input * speed, delta * acceleration)

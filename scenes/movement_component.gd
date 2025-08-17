class_name MovementComponent
extends Node2D

@export var entity: CharacterBody2D

@export var speed: float
@export var acceleration: float
@export var velocity_power: float
@export var dynamic_friction: float

func move(direction: Vector2, delta: float) -> void:
	if !entity:
		return
	
	_handle_movement(direction, delta)
	_apply_friction(direction, delta)
	
	entity.move_and_slide()


func _handle_movement(direction: Vector2, delta: float) -> void:
	var movement: Vector2 = Vector2.ZERO

	var target_speed_x: float = direction.x * speed
	var speed_difference_x: float = target_speed_x - entity.velocity.x
	movement.x = pow(abs(speed_difference_x) * acceleration, velocity_power) * sign(speed_difference_x)

	var target_speed_y: float = direction.y * speed
	var speed_difference_y: float = target_speed_y - entity.velocity.y
	movement.y = pow(abs(speed_difference_y) * acceleration, velocity_power) * sign(speed_difference_y)
	
	entity.velocity += movement * delta


func _apply_friction(direction: Vector2, delta: float) -> void:
	if direction.length() == 0:
		var friction_amount: float = min(dynamic_friction, entity.velocity.length())
		entity.velocity -= entity.velocity.normalized() * friction_amount * delta
	

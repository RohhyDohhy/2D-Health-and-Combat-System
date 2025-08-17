class_name EnemyIdleState
extends State

@export var enemy: CharacterBody2D

@onready var movement_component: MovementComponent = $"../../MovementComponent"

var move_direction: Vector2
var wander_time: float
var idle_time: float

var player: CharacterBody2D
var ctr: int = 0


func _randomize_wander() -> void:
	move_direction = Vector2(randf_range(-1, 1), randf_range(-1, 1)).normalized()
	wander_time = randf_range(1, 3)
	idle_time = randf_range(0, 7)


func enter() -> void:
	_randomize_wander()
	player = get_tree().get_first_node_in_group("Player")


func process(delta: float):
	if wander_time > 0:
		wander_time -= delta
	elif idle_time > 0:
		move_direction = Vector2.ZERO
		idle_time -= delta
	else:
		_randomize_wander()
	
	
	var distance_to_player: float = (player.position - enemy.position).length()
	if distance_to_player <= 100:
		transitioned.emit(self, "follow")
	
	ctr += 1
	
	
func physics_process(delta: float) -> void:
	movement_component.move(move_direction, delta)

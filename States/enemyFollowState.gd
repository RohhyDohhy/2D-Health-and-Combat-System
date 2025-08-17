class_name EnemyFollowState
extends State

@export var enemy: CharacterBody2D
var player: CharacterBody2D
@onready var movement_component: MovementComponent = $"../../MovementComponent"

func enter() -> void:
	player = get_tree().get_first_node_in_group("Player")
	

func physics_process(delta: float) -> void:
	var direction: Vector2 = player.position - enemy.position
	
	if direction.length() > 25:
		movement_component.move(direction.normalized(), delta)
	else:
		enemy.is_attacking = true
		transitioned.emit(self, "attack")
		pass
	if direction.length() > 200:
		transitioned.emit(self, "idle")

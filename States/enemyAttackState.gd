class_name EnemyAttackState
extends State

@export var enemy: CharacterBody2D
var player: CharacterBody2D

func enter() -> void:
	player = get_tree().get_first_node_in_group("Player")
	

func physics_process(_delta: float) -> void:
	if enemy.position.distance_to(player.position) > 25:
		enemy.is_attacking = false	
		transitioned.emit(self, "Follow")
	
	

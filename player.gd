extends CharacterBody2D

@onready var animation_tree: AnimationTree = $AnimationTree
@onready var health_component: HealthComponent = $HealthComponent
@onready var progress_bar: ProgressBar = $ProgressBar


var player_input: Vector2 = Vector2.ZERO
var is_attacking: bool = false
var is_alive: bool = true

func _process(_delta: float) -> void:
	if player_input != Vector2.ZERO:
		animation_tree["parameters/Idle/blend_position"] = player_input
		animation_tree["parameters/Run/blend_position"] = player_input
		animation_tree["parameters/Attack/blend_position"] = player_input
		
	if Input.is_action_just_pressed("attack"):
		is_attacking = true

func _physics_process(delta: float) -> void:
	_handle_input()
	_handle_movement(delta)


func _handle_input() -> void:
	if is_attacking: 
		player_input = Vector2.ZERO
		return
	player_input = Input.get_vector("move_left", "move_right", "move_up", "move_down")


func _handle_movement(delta: float) -> void:
	$MovementComponent.move(player_input, delta)


func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	if anim_name == "attack_left" or anim_name == "attack_right" or anim_name == "attack_down" or anim_name == "attack_up":
		is_attacking = false


func _on_hitbox_body_entered(body: Node2D) -> void:
	if !body.is_in_group("Enemy"):
		return
	
	body.take_damage(20)


func take_damage(amount: float) -> void:
	var attack = Attack.new()
	attack.damage = amount
	health_component.damage(attack)
	progress_bar.value = health_component.health


func _on_health_component_died() -> void:
	print("I DIEEEED NOOOOO")

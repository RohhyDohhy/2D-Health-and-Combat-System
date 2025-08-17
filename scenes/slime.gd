extends CharacterBody2D

@onready var slime: CharacterBody2D = $"."
@onready var health_component: HealthComponent = $HealthComponent
@onready var progress_bar: ProgressBar = $ProgressBar
@onready var animation_tree: AnimationTree = $AnimationTree

var direction: Vector2
var is_attacking: bool = false


func _physics_process(_delta: float) -> void:
	direction = slime.velocity.normalized()
	if direction.length() < 0.01:
		direction = Vector2.ZERO
	if  direction != Vector2.ZERO:
		animation_tree["parameters/Idle/blend_position"] = direction
		animation_tree["parameters/Run/blend_position"] = direction
		animation_tree["parameters/Attack/blend_position"] = direction


func take_damage(amount: float) -> void:
	var attack = Attack.new()
	attack.damage = amount
	health_component.damage(attack)
	progress_bar.value = health_component.health


func _on_hitbox_body_entered(body: Node2D) -> void:
	if !body.is_in_group("Player"):
		return
		
	body.take_damage(20)

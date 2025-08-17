class_name HealthComponent
extends Node2D

signal died

@export var MAX_HEALTH: float
@export var REMOVE_AFTER_DEATH: bool = true

var health: float

func _ready() -> void:
	health = MAX_HEALTH


func damage(attack: Attack) -> void:
	health -= attack.damage
	
	if health <= 0:
		died.emit()
		if REMOVE_AFTER_DEATH:
			get_parent().queue_free()

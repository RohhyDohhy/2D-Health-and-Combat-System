class_name StateMachine
extends Node

@export var initial_state: State

var current_state: State
var states: Dictionary = {}

func _ready() -> void:
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.transitioned.connect(_on_child_transition)

	if initial_state:
		initial_state.enter()
		current_state = initial_state


func _process(delta: float) -> void:
	if current_state:
		current_state.process(delta)
		

func _physics_process(delta: float) -> void:
	if current_state:
		current_state.physics_process(delta)


func _on_child_transition(old_state: State, new_state_name: String) -> void:
	if old_state != current_state:
		return
		
	var new_state = states.get(new_state_name.to_lower())	
	
	if !new_state:
		push_error("Old state must be set!")
		return
		
	if current_state:
		current_state.exit()
		
	new_state.enter()
	current_state = new_state
	

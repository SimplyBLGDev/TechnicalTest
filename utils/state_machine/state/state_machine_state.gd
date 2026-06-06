@icon("uid://comfbf2wjn0jy")
@abstract
class_name StateMachine_State
extends Node

signal on_enter_state
signal on_exit_state

@export var allow_self_transition := false

@onready var state_machine: StateMachine = Utils.find_ancestor_of_type(self, StateMachine)

func on_process(_delta: float) -> void:
	pass


func on_physics_process(_delta: float) -> void:
	pass


func on_input(_event: InputEvent) -> void:
	pass


func on_enter(_from: StateMachine_State):
	pass


func on_exit(_to: StateMachine_State):
	pass


func on_outbound_transition(_to: StateMachine_State):
	pass


func _on_enter_state(from: StateMachine_State):
	on_enter(from)
	on_enter_state.emit()


func _on_exit_state(to: StateMachine_State):
	on_exit(to)
	on_exit_state.emit()


func change_state(to: StateMachine_State):
	if is_instance_valid(state_machine):
		state_machine.change_state(to)
	else:
		push_error("State ", self, " not initialized")


func change_state_name(state_name: StringName):
	if is_instance_valid(state_machine):
		state_machine.change_state_name(state_name)
	else:
		push_error("State ", self, " not initialized")


## Manually triggers all conditional transitions from top to bottom, returns
## true if any condition succeded and a state change is occurring
func trigger_checks() -> bool:
	for _transition in Utils.find_node_descendants_of_type(self, StateMachine_Transition_Condition):
		var transition: StateMachine_Transition_Condition = _transition
		if transition.check():
			return true # Found a match, stop checking
	
	return true

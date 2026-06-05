@icon("uid://b7ijg570yyiuc")
class_name StateMachine
extends Node

signal state_changed(new_state: StateMachine_State)

var state_name_cache: Dictionary[StringName, StateMachine_State] = {}

@export var current_state: StateMachine_State = null

func _enter_tree() -> void:
	if is_node_ready() and is_instance_valid(current_state):
		enter_state(current_state)


func _ready() -> void:
	if not get_parent().is_node_ready():
		await get_parent().ready
	for state in Utils.find_node_descendants_of_type(self, StateMachine_State):
		# Disabling process on inactive nodes saves on performance and also disables
		# the execution of transitions (due to process mode inheritance)
		set_state_process(state, false)
	
	for transition in Utils.find_node_descendants_of_type(self, StateMachine_Transition):
		transition.setup()
	
	if is_instance_valid(current_state):
		enter_state(current_state)


func _process(delta: float) -> void:
	if current_state:
		current_state.on_process(delta)


func _physics_process(delta: float) -> void:
	if current_state:
		current_state.on_physics_process(delta)


func change_state(to: StateMachine_State):
	if to == null:
		push_error("Cannot switch to null state")
		return
	
	if to == current_state and not to.allow_self_transition:
		return
	
	var previous_state := current_state
	if previous_state:
		exit_state(previous_state, to)
	
	enter_state(to, previous_state)
	state_changed.emit(current_state)


func enter_state(state: StateMachine_State, from: StateMachine_State = null):
	set_state_process(state, true)
	current_state = state
	state.on_enter(from)
	state.on_enter_state.emit()


func set_state_process(state: StateMachine_State, process: bool):
	for transition in Utils.find_node_descendants_of_type(state, StateMachine_Transition):
		transition.enabled = process


func exit_state(state: StateMachine_State, to: StateMachine_State):
	set_state_process(state, false)
	state.on_exit(to)
	state.on_exit_state.emit()


func change_state_name(state_name: StringName):
	change_state(get_state(state_name))


func get_state(state_name: StringName) -> StateMachine_State:
	if not state_name_cache.has(state_name):
		state_name_cache[state_name] = find_child(state_name)
	
	return state_name_cache[state_name]

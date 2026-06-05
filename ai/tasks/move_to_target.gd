@tool
extends BTAction

@export var distance_tolerance_squared := 100.0

func _enter() -> void:
	var controller: CharacterController_Patrol = blackboard.get_var(&"controller")
	var target_pos: Vector2 = blackboard.get_var(&"patrol_next_position", Vector2.ZERO)
	controller.navigation_agent.target_position = target_pos


func _tick(_delta: float) -> Status:
	var controller: CharacterController_Patrol = blackboard.get_var(&"controller")
	var agent_2d: CharacterBody2D = agent
	
	var next_path_point := controller.navigation_agent.get_next_path_position()
	var direction_to_next_point := next_path_point - agent_2d.global_position
	controller.move_direction = direction_to_next_point.normalized()
	
	if direction_to_next_point.length_squared() < distance_tolerance_squared:
		return Status.SUCCESS
	
	return Status.RUNNING


func _exit() -> void:
	var controller: CharacterController_Patrol = blackboard.get_var(&"controller")
	controller.move_direction = Vector2.ZERO

extends BTAction

@export var blackboard_target_var := &"targeted_enemy"
@export var blackboard_controller_var := &"controller"

@export var flank_distance := 80.0

func _tick(_delta: float) -> Status:
	var target: Node2D = blackboard.get_var(blackboard_target_var)
	if target == null:
		return Status.FAILURE
	
	var controller: CharacterController_Patrol = blackboard.get_var(blackboard_controller_var)
	
	var distance_to_target: Vector2 = target.global_position - agent.global_position
	if distance_to_target.length_squared() < flank_distance * flank_distance:
		controller.move_direction = Vector2.RIGHT * face_target(target)
		return Status.SUCCESS
	
	controller.navigation_agent.target_position = get_flanking_position(target)
	
	var next_path_point := controller.navigation_agent.get_next_path_position()
	var target_direction: Vector2 = next_path_point - agent.global_position
	controller.move_direction = target_direction.normalized()
	
	return Status.RUNNING


func get_flanking_position(target: Node2D) -> Vector2:
	var flank_side := face_target(target)
	
	return target.global_position + Vector2.RIGHT * flank_distance * flank_side

## Returns -1.0 if the target is to the left of our agent, 1.0 if it is to the right
func face_target(target: Node2D) -> float:
	var distance_to_target: Vector2 = agent.global_position - target.global_position
	var flank_side := signf(distance_to_target.x)
	if flank_side == 0.0:
		# In the RARE case that we are perfectly vertically alligned with the target
		# we default to the right side
		flank_side = 1.0
	
	return flank_side

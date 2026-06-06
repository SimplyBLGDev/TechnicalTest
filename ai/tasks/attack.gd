extends BTAction

@export var blackboard_controller_var := &"controller"

func _tick(_delta: float) -> Status:
	var controller: CharacterController_Patrol = blackboard.get_var(blackboard_controller_var)
	controller.attack()
	return Status.SUCCESS

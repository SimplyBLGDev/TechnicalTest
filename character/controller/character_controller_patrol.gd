class_name CharacterController_Patrol
extends Character_Controller

@export var targeted_enemy_blackboard_var_name := &"targeted_enemy"

@export var navigation_agent: NavigationAgent2D
@export var ai: BTPlayer

func attack():
	attacked.emit()


func _on_vision_cone_body_entered(body: Node2D) -> void:
	if body is not Character:
		return
	
	if body == Utils.find_ancestor_of_type(self, Character):
		return # Ignore self
	
	if ai.blackboard.get_var(targeted_enemy_blackboard_var_name) != null:
		return # We are already targeting someone
	
	ai.blackboard.set_var(targeted_enemy_blackboard_var_name, body)
	body.died.connect(_on_targeted_enemy_died)


func _on_targeted_enemy_died():
	ai.blackboard.set_var(targeted_enemy_blackboard_var_name, null)

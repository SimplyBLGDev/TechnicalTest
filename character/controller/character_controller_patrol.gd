class_name CharacterController_Patrol
extends Character_Controller

@export var navigation_agent: NavigationAgent2D

func attack():
	attacked.emit()

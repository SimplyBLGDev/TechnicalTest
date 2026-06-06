class_name CharacterController_Patrol
extends Character_Controller

@export var targeted_enemy_blackboard_var_name := &"targeted_enemy"

@export var navigation_agent: NavigationAgent2D
@export var ai: BTPlayer
@export var vision_cone: VisionCone

func attack():
	attacked.emit()


func _on_vision_cone_body_entered(body: Node2D) -> void:
	if body is not Character:
		return
	
	if body == Utils.find_ancestor_of_type(self, Character):
		return # Ignore self
	
	if body.is_dead():
		return # Ignore dead characters
	
	if ai.blackboard.get_var(targeted_enemy_blackboard_var_name) != null:
		return # We are already targeting someone
	
	alert()
	target_enemy(body)


func _on_targeted_enemy_died():
	ai.blackboard.set_var(targeted_enemy_blackboard_var_name, null)


func _on_hurtbox_got_hit(_damage: int, _hit_position: Vector2, hurt_by: Hitbox) -> void:
	if hurt_by.owner is Character:
		alert()
		target_enemy(hurt_by.owner)


func alert():
	var character: Character = Utils.find_ancestor_of_type(self, Character)
	var alert_fx := FX_Alert.instantiate()
	character.add_sibling(alert_fx)
	alert_fx.global_position = character.head_position.global_position
	vision_cone.hide()


func target_enemy(enemy: Character):
	if ai.blackboard.get_var(targeted_enemy_blackboard_var_name) != enemy:
		ai.blackboard.set_var(targeted_enemy_blackboard_var_name, enemy)
		enemy.died.connect(_on_targeted_enemy_died)

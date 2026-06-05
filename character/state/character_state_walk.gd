extends Character_State

@export var animation := &"walk"

func on_enter(_from: StateMachine_State):
	character.animation_player.play(animation)
	character.controller.attacked.connect(_on_attacked)


func on_exit(_to: StateMachine_State):
	character.controller.attacked.disconnect(_on_attacked)


func _on_attacked():
	change_state_name(ATTACK)


func on_physics_process(_delta: float) -> void:
	var move_direction := character.controller.move_direction.normalized()
	var target_velocity := move_direction * character.parameters.top_speed
	character.velocity = target_velocity
	character.move_and_slide()
	
	if move_direction.x != 0.0:
		character.facing_left = move_direction.x < 0.0

extends Character_State

@export var animation := &"walk"

func on_enter(_from: StateMachine_State):
	player.animation_player.play(animation)
	player.controller.attacked.connect(_on_attacked)


func on_exit(_to: StateMachine_State):
	player.controller.attacked.disconnect(_on_attacked)


func _on_attacked():
	change_state_name(ATTACK)


func on_physics_process(_delta: float) -> void:
	var move_direction := player.controller.move_direction.normalized()
	var target_velocity := move_direction * player.parameters.top_speed
	player.velocity = target_velocity
	player.move_and_slide()
	
	if move_direction.x != 0.0:
		player.facing_left = move_direction.x < 0.0

extends Player_State

@export var animation := &"attack"

func on_enter(_from: StateMachine_State):
	player.animation_player.play(animation)
	await player.animation_player.animation_finished
	change_state_name(IDLE)

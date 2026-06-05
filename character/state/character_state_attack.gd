extends Character_State

@export var animation := &"attack"

func on_enter(_from: StateMachine_State):
	character.animation_player.play(animation)
	await character.animation_player.animation_finished
	change_state_name(IDLE)

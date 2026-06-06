extends Character_State

@export var animation := &"attack"

func on_enter(_from: StateMachine_State):
	character.animation_player.play(animation)
	character.animation_player.animation_finished.connect(_on_animation_finished)


func on_exit(_to: StateMachine_State):
	character.animation_player.animation_finished.disconnect(_on_animation_finished)


func _on_animation_finished(_animation_name: StringName):
	change_state_name(IDLE)

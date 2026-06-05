extends Character_State

@export var animation := &"idle"

func on_enter(_from: StateMachine_State):
	character.animation_player.play(animation)
	character.velocity = Vector2.ZERO
	character.controller.attacked.connect(_on_attacked)


func on_exit(_to: StateMachine_State):
	character.controller.attacked.disconnect(_on_attacked)


func _on_attacked():
	change_state_name(ATTACK)

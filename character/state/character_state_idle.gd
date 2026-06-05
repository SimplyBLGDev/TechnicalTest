extends Character_State

@export var animation := &"idle"

func on_enter(_from: StateMachine_State):
	player.animation_player.play(animation)
	player.velocity = Vector2.ZERO
	player.controller.attacked.connect(_on_attacked)


func on_exit(_to: StateMachine_State):
	player.controller.attacked.disconnect(_on_attacked)


func _on_attacked():
	change_state_name(ATTACK)

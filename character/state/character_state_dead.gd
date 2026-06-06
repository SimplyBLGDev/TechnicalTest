extends Character_State

@export var animation := &"die"

func on_enter(_from: StateMachine_State):
	# Explode
	var explosion := FX_Explosion.instantiate()
	character.add_sibling(explosion)
	explosion.global_position = character.global_position
	
	# Play die animation
	character.animation_player.play(animation)
	
	# Hide the HUD elements
	character.hud.hide()
	
	character._disable_collisions()
	
	character.velocity = Vector2.ZERO

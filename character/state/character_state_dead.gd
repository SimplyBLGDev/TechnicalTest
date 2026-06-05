extends Character_State

func on_enter(_from: StateMachine_State):
	# Explode
	character.add_sibling(FX_Explosion.instantiate())
	
	# Lay the character on its side and make it semi-transparent
	character.rotation = PI / 2.0
	character.modulate.a = 0.5
	
	# Hide the HUD elements
	character.hud.hide()
	
	character.velocity = Vector2.ZERO

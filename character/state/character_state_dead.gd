extends Character_State

func on_enter(_from: StateMachine_State):
	# Explode
	var explosion := FX_Explosion.instantiate()
	character.add_sibling(explosion)
	explosion.global_position = character.global_position
	
	# Lay the character on its side and make it semi-transparent
	character.rotation = -PI / 2.0
	character.modulate.a = 0.5
	
	# Hide the HUD elements
	character.hud.hide()
	
	character.velocity = Vector2.ZERO


func on_exit(_to: StateMachine_State):
	print(_to.name)

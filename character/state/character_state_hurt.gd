class_name Character_State_Hurt
extends Character_State

func on_enter(_from: StateMachine_State):
	character.velocity = Vector2.RIGHT if character.facing_left else Vector2.LEFT
	character.velocity *= character.parameters.knockback_speed
	character.sprite.hurt_flash(character.parameters.hit_flash_intensity, character.parameters.hit_flash_duration)
	await get_tree().create_timer(character.parameters.knockback_duration).timeout
	change_state_name(IDLE)


func on_physics_process(_delta: float) -> void:
	character.move_and_slide()

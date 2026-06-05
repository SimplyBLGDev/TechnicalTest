class_name Character_State_Hurt
extends Character_State

func on_enter(_from: StateMachine_State):
	player.velocity = Vector2.RIGHT if player.facing_left else Vector2.LEFT
	player.velocity *= player.parameters.knockback_speed
	player.sprite.hurt_flash(player.parameters.hit_flash_intensity, player.parameters.hit_flash_duration)
	await get_tree().create_timer(player.parameters.knockback_duration).timeout
	change_state_name(IDLE)


func on_physics_process(_delta: float) -> void:
	player.move_and_slide()

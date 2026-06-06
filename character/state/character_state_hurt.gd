class_name Character_State_Hurt
extends Character_State

var hit_position := Vector2.ZERO
var knockback_duration_left := 0.0

func on_enter(_from: StateMachine_State):
	# Apply knockback
	character.velocity = Vector2.LEFT if hit_position.x > 0.0 else Vector2.RIGHT
	character.velocity *= character.parameters.knockback_speed
	character.sprite.hurt_flash(character.parameters.hit_flash_intensity, character.parameters.hit_flash_duration)
	
	knockback_duration_left = character.parameters.knockback_duration


func on_physics_process(delta: float) -> void:
	character.move_and_slide()
	knockback_duration_left -= delta
	if knockback_duration_left <= 0.0:
		change_state_name(IDLE)

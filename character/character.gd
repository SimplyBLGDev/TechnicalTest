class_name Character
extends CharacterBody2D

signal hurt
signal flipped_horizontally(is_flipped: bool)
signal died

@export var parameters: Character_Parameters

@export_group("Components")
@export var controller: Character_Controller
@export var state_machine: StateMachine
@export var sprite: Character_Sprite
@export var animation_player: AnimationPlayer
@export var health_component: HealthComponent
@export var hurtbox: Hurtbox
@export var hud: Character_HUD
@export var head_position: Node2D

var facing_left:
	set(value):
		if value != sprite.flip_h:
			flipped_horizontally.emit(value)
		sprite.flip_h = value
	get:
		return sprite.flip_h

func spawn_hitbox(hitbox_scene: PackedScene, duration: float):
	var instance: Hitbox = hitbox_scene.instantiate()
	add_child(instance)
	instance.owner = self
	if facing_left:
		instance.mirror_horizontally()
	
	await get_tree().create_timer(duration).timeout
	instance.queue_free()


func _on_hurtbox_got_hit(damage: int, hit_position: Vector2) -> void:
	var hurt_state: Character_State_Hurt = state_machine.get_state(Character_State.HURT)
	hurt_state.hit_position = hit_position
	hurt_state.damage = damage
	hurt.emit()
	health_component.receive_damage(damage)


func _on_health_component_health_depleted() -> void:
	state_machine.change_state_name(Character_State.DEAD)
	died.emit()


func _disable_collisions():
	collision_mask &= 0
	collision_layer &= 0


func is_dead() -> bool:
	return health_component.is_depleted()

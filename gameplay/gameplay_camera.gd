extends Camera2D

@export_custom(PROPERTY_HINT_NONE, "suffix:px") var shake_intensity := 10.0
@export_custom(PROPERTY_HINT_NONE, "suffix:s") var shake_duration := 0.3
@export_custom(PROPERTY_HINT_NONE, "suffix:s") var fade_duration := 2.0
@export var post_processing: ShaderMaterial

var _animating_tween: Tween

func shake() -> void:
	if _animating_tween:
		_animating_tween.kill()
		_animating_tween = null
	
	offset = Vector2.UP * shake_intensity
	_animating_tween = create_tween().set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_BOUNCE)
	_animating_tween.tween_property(self, ^"offset", Vector2.ZERO, shake_duration)
	_animating_tween.play()


func fade_to_bw():
	await get_tree().create_timer(2.0).timeout
	
	if _animating_tween:
		_animating_tween.kill()
		_animating_tween = null
	
	_animating_tween = create_tween()
	_animating_tween.tween_method(_set_post_process_desaturation, 0.0, 1.0, fade_duration)
	_animating_tween.play()


func _set_post_process_desaturation(amount: float):
	post_processing.set_shader_parameter(&"desaturation", amount)

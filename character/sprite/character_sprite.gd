class_name Character_Sprite
extends Sprite2D

func hurt_flash(intensity: float, duration: float):
	var shader: ShaderMaterial = material
	shader.set_shader_parameter(&"over_exposition", intensity)
	await get_tree().create_timer(duration).timeout
	shader.set_shader_parameter(&"over_exposition", 0.0)

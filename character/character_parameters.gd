class_name Character_Parameters
extends Resource

@export_custom(PROPERTY_HINT_NONE, "suffix:px/s") var top_speed := 300.0
@export_custom(PROPERTY_HINT_NONE, "suffix:px/s") var knockback_speed := 200.0
@export_custom(PROPERTY_HINT_NONE, "suffix:s") var knockback_duration := 0.4

@export_group("Animation parameters")
@export_custom(PROPERTY_HINT_NONE, "suffix:s") var hit_flash_duration := 0.15
@export_range(0.0, 1.0, 0.01, "suffix:s") var hit_flash_intensity := 1.0

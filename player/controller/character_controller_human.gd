extends Character_Controller

@export_group("Inputs")
@export var _movement: GUIDEAction
@export var _attack: GUIDEAction

func _ready():
	_attack.triggered.connect(attacked.emit)


func _process(_delta: float) -> void:
	move_direction = _movement.value_axis_2d

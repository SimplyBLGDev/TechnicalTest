class_name StateMachine_Transition_Condition
extends StateMachine_Transition

## Expression to be evaluated, variables are taken from this transition's
## state machine's evaluation context
@export_multiline var condition := ""
## If enabled the expression will be evaluated in physics process() instead of process()
@export var check_on_physics_process := false
## If enabled condition will not be checked at any point unless check() is manually called
@export var manual_check_only := false

var evaluation_context: Node
var expression := Expression.new()

# Called by StateMachine when it is ready
func setup():
	set_process(not check_on_physics_process and not manual_check_only)
	set_physics_process(check_on_physics_process and not manual_check_only)
	get_state().on_enter_state.connect(check_expression_fetch_delta)
	evaluation_context = get_evaluation_context()
	expression.parse(condition, ["delta"])


func check() -> bool:
	return check_expression_fetch_delta()


func _process(delta: float) -> void:
	check_expression(delta)


func _physics_process(delta: float) -> void:
	check_expression(delta)


func check_expression_fetch_delta() -> bool:
	var delta := get_physics_process_delta_time() if check_on_physics_process else get_process_delta_time()
	return check_expression(delta)


func check_expression(delta: float) -> bool:
	if not enabled:
		return false
	
	var result = expression.execute([delta], evaluation_context)
	if expression.has_execute_failed():
		push_error(expression.get_error_text())
		return false
	
	if result:
		trigger()
		return true
	return false

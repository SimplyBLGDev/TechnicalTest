class_name Character_State
extends StateMachine_State

#region State name constants
const IDLE := "Idle"
const WALK := "Walk"
const ATTACK := "Attack"
const HURT := "Hurt"
const DEAD := "Dead"
#endregion

var character: Character

func _ready():
	character = Utils.find_ancestor_of_type(self, Character)

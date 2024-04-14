class_name CardStateMachine

extends Node2D

@export var initialState : CardState

var currentState : CardState
var states := {}

func init(card : CardUI) -> void:
	for child: CardState in get_children():
		if child:
			states[child.state] = child
			child.transition_requested.connect(on_transition_requested)
			child.cardUI = card
			
	if initialState:
		initialState.enter()
		currentState = initialState

func on_input(event: InputEvent) -> void:
	if currentState:
		currentState.on_input(event)
		
func on_gui_input(event: InputEvent) -> void:
	if currentState:
		currentState.on_gui_input(event)
		
func on_mouse_entered() -> void:
	if currentState:
		currentState.on_mouse_entered()
		
func on_mouse_exited() -> void:
	if currentState:
		currentState.on_mouse_exited()
		
func on_transition_requested(from: CardState, to : CardState.State) -> void:
	if from != currentState:
		return
		
	var newState: CardState = states[to]
	
	if not newState:
		return
		
	if currentState:
		currentState.exit()
		
	newState.enter()
	currentState = newState
	

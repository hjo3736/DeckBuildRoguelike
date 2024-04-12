extends CardState

const DRAG_MINIMUN_THRESHHOLD := 0.05

var minDragTimeElapsed := false

func enter():
	var UILayer = get_tree().get_first_node_in_group("UILayer")
	if UILayer:
		cardUI.reparent(UILayer)
	
	cardUI.color.color = Color.NAVY_BLUE
	cardUI.state.text = "Dragging"
	
	minDragTimeElapsed = false
	var threshhold_timer = get_tree().create_timer(DRAG_MINIMUN_THRESHHOLD, false)
	threshhold_timer.timeout.connect(func(): minDragTimeElapsed = true)

func on_input(event: InputEvent) -> void:
	var mouse_motion = event is InputEventMouseMotion
	var cancel = event.is_action_released("right_mouse")
	var confirm = event.is_action_pressed("left_mouse") or event.is_action_pressed("left_mouse")
	
	if mouse_motion:
		cardUI.global_position = cardUI.get_global_mouse_position() - cardUI.pivot_offset
		
	if cancel:
		transition_requested.emit(self, CardState.State.BASE)
	elif minDragTimeElapsed and confirm:
		get_viewport().set_input_as_handled()
		transition_requested.emit(self,CardState.State.RELEASED)

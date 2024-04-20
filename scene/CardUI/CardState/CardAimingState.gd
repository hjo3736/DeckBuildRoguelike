extends CardState

const MOUSE_Y_SNAPBACK_THRESHHOLD := 138

func enter() -> void:
	cardUI.targets.clear()
	
	var offset := Vector2(cardUI.parent.size.x / 2, -cardUI.parent.size.y / 2)
	offset.x -= cardUI.size.x / 2
	cardUI.animate_to_position(cardUI.parent.global_position + offset, 0.2)
	cardUI.dropPointDetector.monitoring = false
	
	Events.card_aim_started.emit(cardUI)
	
func exit() -> void:
	Events.card_aim_ended.emit(cardUI)
	
func on_input(event: InputEvent) -> void:
	var isMouseMotion = event is InputEventMouseMotion
	var isMouseAtBottom = cardUI.get_global_mouse_position().y > MOUSE_Y_SNAPBACK_THRESHHOLD
	
	if(isMouseMotion and isMouseAtBottom) or event.is_action_pressed("right_mouse"):
		transition_requested.emit(self, CardState.State.BASE)
	elif event.is_action_released("left_mouse") or event.is_action_pressed("left_mouse"):
		get_viewport().set_input_as_handled()
		transition_requested.emit(self, CardState.State.RELEASED)

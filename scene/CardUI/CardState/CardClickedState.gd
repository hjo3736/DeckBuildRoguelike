extends CardState

func enter():
	cardUI.color.color = Color.ORANGE
	cardUI.state.text = "Clicked"
	cardUI.drop_point_detector.monitoring = true
	
func on_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		transition_requested.emit(self, CardState.State.DRAGGING)

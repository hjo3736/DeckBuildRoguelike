extends CardState

func enter():
	cardUI.dropPointDetector.monitoring = true
	
func on_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		transition_requested.emit(self, CardState.State.DRAGGING)

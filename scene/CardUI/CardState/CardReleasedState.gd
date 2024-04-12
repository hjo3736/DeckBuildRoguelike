extends CardState

var played: bool

func enter() -> void:
	cardUI.color.color = Color.DARK_VIOLET
	cardUI.state.text = "Released"

	played = false
	
	if not cardUI.targets.is_empty():
		played = true
		print("play card for target(s) : ", cardUI.targets)
	
func on_input(_event: InputEvent) -> void:
	if played:
		return
	
	transition_requested.emit(self, CardState.State.BASE)

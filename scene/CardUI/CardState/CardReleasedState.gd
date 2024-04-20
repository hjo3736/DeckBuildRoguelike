extends CardState

var played: bool

func enter() -> void:
	played = false
	
	cardUI.border.set("theme_override_styles/panel", cardUI.borderIdle)
	
	if not cardUI.targets.is_empty():
		played = true
		cardUI.play()
		
	
func on_input(_event: InputEvent) -> void:
	if played:
		return
	
	transition_requested.emit(self, CardState.State.BASE)

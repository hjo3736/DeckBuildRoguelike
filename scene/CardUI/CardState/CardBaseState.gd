extends CardState

func enter():
	if not is_node_ready():
		await cardUI.ready
	
	if cardUI.tween and cardUI.tween.is_running():
		cardUI.tween.kill()
	cardUI.reparent_request.emit(cardUI)
	cardUI.pivot_offset = Vector2.ZERO
	
func on_gui_input(event: InputEvent) -> void:
	if not cardUI.playable or cardUI.disabled:
		return
	
	if event.is_action_pressed("left_mouse"):
		cardUI.pivot_offset = cardUI.get_global_mouse_position() - cardUI.global_position
		transition_requested.emit(self, CardState.State.CLICK)

func on_mouse_exited() -> void:
	if not cardUI.playable or cardUI.disabled:
		return

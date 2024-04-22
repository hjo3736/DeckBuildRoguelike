extends EnemyAction

@export var block := 6

func performAction() -> void:
	if not enemy or not target:
		return
	
	var defendEffect := DefendEffect.new()
	defendEffect.amount = block
	defendEffect.execute([enemy])
	
	get_tree().create_timer(0.6, false).timeout.connect(
		func():
			Events.enemy_action_completed.emit(enemy)
	)

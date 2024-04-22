extends EnemyAction

@export var block := 10
@export var hpThreshhold := 6

var isAlreadyUsed := false

func isPerformable() -> bool:
	if not enemy or isAlreadyUsed:
		return false
	
	var isLow := enemy.stats.health <= hpThreshhold
	isAlreadyUsed = isLow
	
	return isLow

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

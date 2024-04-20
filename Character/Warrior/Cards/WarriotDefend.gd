extends Card

func applyEffects(targets: Array[Node]) -> void:
	var defendEffect := DefendEffect.new()
	defendEffect.amount = 3
	defendEffect.execute(targets)

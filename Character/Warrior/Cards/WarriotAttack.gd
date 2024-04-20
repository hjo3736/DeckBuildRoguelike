extends Card

func applyEffects(targets: Array[Node]) -> void:
	var attackEffect := AttackEffect.new()
	attackEffect.amount = 5
	attackEffect.execute(targets)

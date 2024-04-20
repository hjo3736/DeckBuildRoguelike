class_name Hand

extends HBoxContainer

var cardsPlayedThisTurn := 0

func _ready() -> void:
	
	Events.card_played.connect(_on_card_played)
	
	for child in get_children():
		var cardUI := child as CardUI
		cardUI.parent = self
		cardUI.reparent_request.connect(_on_card_ui_reparent_requested)

func _on_card_played(_card: Card) -> void:
	cardsPlayedThisTurn += 1

func _on_card_ui_reparent_requested(child: CardUI) -> void:
	child.reparent(self)
	var newIndex := clampi(child.originalIndex- cardsPlayedThisTurn, 0, get_child_count())
	move_child.call_deferred(child, newIndex)

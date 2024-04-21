class_name Hand

extends HBoxContainer

@export var charStat: CharacterStats

@export var cardUI := preload("res://Scene/CardUI/CardUI.tscn")

var cardsPlayedThisTurn := 0

func _ready() -> void:
	Events.card_played.connect(_on_card_played)

func addCard(card: Card) -> void:
	var newCardUI := cardUI.instantiate()
	add_child(newCardUI)
	newCardUI.reparent_request.connect(_on_card_ui_reparent_requested)
	newCardUI.card = card
	newCardUI.parent = self
	newCardUI.charStat = charStat

func discardCard(card: CardUI) -> void:
	card.queue_free()

func disableHand() -> void:
	for card in get_children():
		card.disabled = true

func _on_card_played(_card: Card) -> void:
	cardsPlayedThisTurn += 1

func _on_card_ui_reparent_requested(child: CardUI) -> void:
	child.disabled = true
	child.reparent(self)
	var newIndex := clampi(child.originalIndex- cardsPlayedThisTurn, 0, get_child_count())
	move_child.call_deferred(child, newIndex)
	child.set_deferred("disabled", true)

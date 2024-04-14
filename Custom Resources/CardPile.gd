class_name CardPile

extends Resource

signal card_pile_size_changed(cards_amount)

@export var cards: Array[Card] = []

func empty() -> bool:
	return cards.is_empty()
	
func drawCard() -> Card:
	var card = cards.pop_front()
	card_pile_size_changed.emit(cards.size())
	return card

func addCard(card: Card) -> void:
	cards.append(card)
	card_pile_size_changed.emit(cards.size()) 

func shuffle() -> void:
	cards.shuffle()
	
func clear() -> void:
	cards.clear()
	card_pile_size_changed.emit(cards.size())

func _to_string() -> String:
	var _cardStrings: PackedStringArray = []
	for i in range(cards.size()):
		_cardStrings.append("%s: %s" % [i+1, cards[i].id])
	return "\n".join(_cardStrings)

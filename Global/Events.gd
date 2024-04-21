extends Node

signal card_drag_started(cardUI: CardUI)
signal card_drag_ended(cardUI: CardUI)
signal card_aim_started(cardUI: CardUI)
signal card_aim_ended(cardUI: CardUI)
signal card_played(card: Card)
signal card_tooltip_requested(card: Card)
signal tooltip_hide_requested

signal player_hand_drawn
signal player_hand_discarded
signal player_turn_ended

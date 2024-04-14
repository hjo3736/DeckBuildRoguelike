class_name Hand

extends HBoxContainer

func _ready() -> void:
	for child in get_children():
		var cardUI := child as CardUI
		cardUI.parent = self
		cardUI.reparent_request.connect(_on_card_ui_reparent_requested)

func _on_card_ui_reparent_requested(child: CardUI) -> void:
	child.reparent(self)

class_name IntentUI

extends HBoxContainer

@onready var icon: TextureRect = $Icon
@onready var value: Label = $Value

func updateIntent(intent: Intent) -> void:
	if not intent:
		hide()
		return
	
	icon.texture = intent.icon
	icon.visible = icon.texture != null
	
	value.text = str(intent.value)
	value.visible = intent.value.length() > 0
	
	print(value.visible)
	
	show()

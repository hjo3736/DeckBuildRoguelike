extends Node

func shake(thing: Node2D, strength: float, duration: float = 0.2) -> void:
	if not thing:
		return
	
	var orgPos := thing.position
	var shakeCount := 10
	var tween := create_tween()
	
	for i in shakeCount:
		var shakeOffset := Vector2(randf_range(-0.7, 0.7), randf_range(-0.7, 0.7))
		var target := orgPos + strength * shakeOffset
		
		if i % 2 == 0:
			target = orgPos
		
		tween.tween_property(thing, "position", target, duration / float(shakeCount))
		strength * 0.75
	
	tween.finished.connect(func(): thing.position = orgPos)

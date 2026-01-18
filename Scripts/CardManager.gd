extends Node2D

var cardBeingDragged 


func _input(event: InputEvent):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			var card = raycastCheckForCard()
			if card:
				cardBeingDragged = card
		else:
			cardBeingDragged = null

func raycastCheckForCard():
	var spaceState = get_world_2d().direct_space_state
	var parameters = PhysicsPointQueryParameters2D.new()
	parameters.position = get_global_mouse_position()
	parameters.collide_with_areas = true
	parameters.collision_mask = 1
	var result = spaceState.intersect_point(parameters)
	if result.size() > 0:
		return result[0].collider.get_parent()
	else:
		return null

func _process(_delta: float) -> void:
	if cardBeingDragged:
		var mousePos = get_global_mouse_position()
		cardBeingDragged.position = mousePos

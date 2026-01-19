extends Node2D


const CARD_WIDTH = 200
const HAND_Y_POSITION = 458
const DEFAULT_CARD_MOVE_SPEED = 0.1
var playerHand = []
var centerScreenX
func _ready() -> void:
	centerScreenX = get_viewport().size.x / 2

func addCardToHand(card, speed):
	if card not in playerHand:
		playerHand.insert(0,card)
		updateHandPositions(speed)
	else:
		animateCardToPosition(card, card.hand_position, DEFAULT_CARD_MOVE_SPEED)
func updateHandPositions(speed):
	for i in range(playerHand.size()):
		var new_position = Vector2(calculateCardPosition(i),HAND_Y_POSITION)
		var card = playerHand[i]
		animateCardToPosition(card, new_position, speed)
		card.hand_position = new_position
func animateCardToPosition(card, position, speed):
	var tween = get_tree().create_tween()
	tween.tween_property(card, "position", position, speed)
func calculateCardPosition(index):
	var total_width = (playerHand.size() - 1) * CARD_WIDTH
	var x_offset = centerScreenX + index * CARD_WIDTH - total_width / 2
	return x_offset
func removeCardFromHand(card):
	if card in playerHand:
		playerHand.erase(card)
		updateHandPositions(DEFAULT_CARD_MOVE_SPEED)

extends CanvasLayer

@onready var hp_label = $VBoxContainer/Label
@onready var key_label = $VBoxContainer/Label2

var player: Node

func _process(delta: float) -> void:
	if player != null:
		hp_label.text = "HP: " + str(player.health)
		key_label.text = "Key: " + str(player.key)

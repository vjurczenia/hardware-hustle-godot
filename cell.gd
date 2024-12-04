extends Node

var value: set = set_value
@export var editable = false: set = set_editable
var _is_ready = false


func set_value(new_value) -> void:
	value = new_value
	$ValueLabel.text = str(value)
	render_editable()
	if editable:
		Global.cell_value_updated.emit()
		

func set_editable(new_editable) -> void:
	editable = new_editable
	render_editable()


func render_editable() -> void:
	if _is_ready:
		if editable:
			if value > 0:
				$DecreaseButton.show()
			else:
				$DecreaseButton.hide()
			$IncreaseButton.show()
		else:
			$DecreaseButton.hide()
			$IncreaseButton.hide()


func _ready() -> void:
	_is_ready = true
	value = 0
	render_editable()


func _on_decrease_button_pressed() -> void:
	value = value - 1


func _on_increase_button_pressed() -> void:
	value = value + 1

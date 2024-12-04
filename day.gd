extends Node2D


var phase: String: 
	get:
		return ["Buy", "Make", "Sell"][phase_index]


var phase_index: int:
	set(new_phase_index):
		phase_index = new_phase_index % 3
		disable_all_cells()
		for cell in Global.value_map[phase]:
			get_node(str(phase, "/", cell)).editable = true


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Global.cell_value_updated.connect(on_cell_value_updated)
	phase_index = 0
	$"AM/Money".value = Global.starting_money


func on_cell_value_updated():
	var column_totals = {}
	for choice in Global.value_map[phase]:
		for resource in Global.value_map[phase][choice]:
			column_totals[resource] = column_totals.get_or_add(resource, 0) + get_node(str(phase, "/", choice)).value * Global.value_map[phase][choice][resource]
	
	for resource in column_totals:
		get_node(str(phase, "/", resource)).value = column_totals[resource]

	var day_totals = {}
	for column in Global.cell_multipliers:
		for row in Global.cell_multipliers[column]:
			day_totals[row] = day_totals.get_or_add(row, 0) + get_node(str(column, "/", row)).value * Global.cell_multipliers[column][row]
	
	for row in day_totals:
		get_node(str("PM/", row)).value = day_totals[row]

func disable_all_cells():
	for column in get_children():
		for cell in column.get_children():
			cell.editable = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_advance_phase_pressed() -> void:
	phase_index += 1


func _on_end_day_pressed() -> void:
	pass # Replace with function body.

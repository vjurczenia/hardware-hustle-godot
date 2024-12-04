extends Node

signal cell_value_updated

var starting_money = 10

var starting_opportunity_per_day = [12, 12, 8, 8, 4, 4]

var phase_to_active_cells = {
	"Buy": ["Enclosure", "Speaker", "Controls", "Processor"],
	"Make": ["Amplifier", "Noisebox", "Synth"],
	"Sell": ["Amplifier", "Noisebox", "Synth"],
}

var max_level = 3

var buy_level = 0
var make_level = 0
var sell_level = 0

var value_map: 
	get:
		return {
			"Buy": {
				"Enclosure": {
					"Money": 1,
					"Opportunity": [0,0,0,0][buy_level],
				},
				"Speaker": {
					"Money": 2,
					"Opportunity": [1,0,0,0][buy_level],
				},
				"Controls": {
					"Money": 3,
					"Opportunity": [2,1,0,0][buy_level],
				},
				"Processor": {
					"Money": 4,
					"Opportunity": [3,2,1,0][buy_level],
				},
			},
			"Make": {
				"Amplifier": {
					"Enclosure": 1,
					"Speaker": 1,
					"Opportunity": [1,0,0,0][make_level],
				},
				"Noisebox": {
					"Enclosure": 1,
					"Speaker": 1,
					"Controls": 1,
					"Opportunity": [2,1,0,0][make_level],
				},
				"Synth": {
					"Enclosure": 1,
					"Speaker": 1,
					"Controls": 1,
					"Processor": 1,
					"Opportunity": [3,2,1,0][make_level],
				},
			},
			"Sell": { 
				"Amplifier": {
					"Money": 6,
					"Opportunity": [2,1,0,0][sell_level],
				},
				"Noisebox": {
					"Money": 18,
					"Opportunity": [3,2,1,0][sell_level],
				},
				"Synth": {
					"Money": 40,
					"Opportunity": [4,3,2,1][sell_level],
				},
			},
		}
		
var cell_multipliers = {
	"AM": {
		"Money": 1,
		"Enclosure": 1,
		"Speaker": 1,
		"Controls": 1,
		"Processor": 1,
		"Amplifier": 1,
		"Noisebox": 1,
		"Synth": 1,
		"Opportunity": 1,
	},
	"Buy": {
		"Money": -1,
		"Enclosure": 1,
		"Speaker": 1,
		"Controls": 1,
		"Processor": 1,
		"Amplifier": 1,
		"Noisebox": 1,
		"Synth": 1,
		"Opportunity": 1,
	},
	"Make": {
		"Money": 1,
		"Enclosure": -1,
		"Speaker": -1,
		"Controls": -1,
		"Processor": -1,
		"Amplifier": 1,
		"Noisebox": 1,
		"Synth": 1,
		"Opportunity": 1,
	},
	"Sell": {
		"Money": 1,
		"Enclosure": 1,
		"Speaker": 1,
		"Controls": 1,
		"Processor": 1,
		"Amplifier": -1,
		"Noisebox": -1,
		"Synth": -1,
		"Opportunity": 1,
	},
}

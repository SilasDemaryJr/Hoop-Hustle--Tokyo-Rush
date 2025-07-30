extends Node

# Signals
signal dialogue_started()
signal dialogue_ended()

# UI elements
@onready var dialogue_panel = $CanvasLayer/DialoguePanel
@onready var dialogue_text = $CanvasLayer/DialoguePanel/DialogueText
@onready var next_button = $CanvasLayer/DialoguePanel/NextButton

# Dialogue data
var dialogue_data = {}
var current_dialogue = []
var current_line = 0
var is_dialogue_active = false

func _ready():
	# Load dialogue from JSON file
	var file = FileAccess.open("res://dialogue.json", FileAccess.READ)
	if file:
		var json_text = file.get_as_text()
		dialogue_data = JSON.parse_string(json_text)
		file.close()
	else:
		print("Error: Could not load dialogue.json")
	
	# Hide dialogue UI initially
	dialogue_panel.visible = false
	
	# Connect button signal
	next_button.pressed.connect(_on_next_button_pressed)

func start_dialogue(dialogue_id: String):
	if dialogue_data.has(dialogue_id) and not is_dialogue_active:
		current_dialogue = dialogue_data[dialogue_id]
		current_line = 0
		is_dialogue_active = true
		dialogue_panel.visible = true
		emit_signal("dialogue_started")
		_update_dialogue()
	else:
		print("Error: Dialogue ID not found or dialogue already active")

func _update_dialogue():
	if current_line < current_dialogue.size():
		dialogue_text.text = current_dialogue[current_line]
	else:
		_end_dialogue()

func _end_dialogue():
	is_dialogue_active = false
	dialogue_panel.visible = false
	current_dialogue = []
	current_line = 0
	emit_signal("dialogue_ended")

func _on_next_button_pressed():
	if is_dialogue_active:
		current_line += 1
		_update_dialogue()

extends Node

signal file_to_load_changed(file_path)
#warning-ignore:unused_signal
signal model_loaded()
#warning-ignore:unused_signal
signal properties_applied()
#warning-ignore:unused_signal
signal properties_reset()
signal gui_toggle_set(toggle_name)
#warning-ignore:unused_signal
signal face_tracker_offsets_set()
#warning-ignore:unused_signal
signal console_log(message)

enum ModelType { GENERIC, VRM }

const DYNAMIC_PHYSICS_BONES: bool = false

# Face tracker
var is_face_tracker_running: bool
var face_tracker_pid: int

# TODO disable OpenSeeGD during debug i guess
var is_face_tracking_disabled: bool = true

###############################################################################
# Builtin functions                                                           #
###############################################################################

func _ready() -> void:
	self.connect("tree_exiting", self, "_on_tree_exiting")

###############################################################################
# Connections                                                                 #
###############################################################################

func _on_tree_exiting() -> void:
	if is_face_tracker_running:
		OS.kill(face_tracker_pid)
	
	push_log("Exiting. おやすみ。")

###############################################################################
# Private functions                                                           #
###############################################################################

###############################################################################
# Public functions                                                            #
###############################################################################

func save_facetracker_offsets() -> void:
	emit_signal("face_tracker_offsets_set")

func apply_properties() -> void:
	emit_signal("properties_applied")

func reset_properties() -> void:
	emit_signal("properties_reset")

func gui_toggle_set(toggle_name: String) -> void:
	emit_signal("gui_toggle_set", toggle_name)

func set_file_to_load(file_path: String) -> void:
	emit_signal("file_to_load_changed", file_path)

# TODO implement at some point
func load_or_create_model_config() -> Dictionary:
	var result: Dictionary = {}

	return result

# TODO implement at some point
func save_model_config(value: Dictionary) -> void:
	pass

func push_log(message: String) -> void:
	print(message)
	emit_signal("console_log", message)

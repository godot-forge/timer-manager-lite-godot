@tool
extends EditorPlugin

func _enter_tree() -> void:
	add_autoload_singleton("TimerManager", "res://addons/timer_manager_lite/timer_manager.gd")

func _exit_tree() -> void:
	remove_autoload_singleton("TimerManager")

extends Node

const MAX_TIMERS: int = 8

enum TimerMode { COUNTDOWN, REPEAT, DELAY }

signal timer_finished(timer_id: String)
signal timer_tick(timer_id: String, remaining: float)

var _timers: Dictionary = {}

func _process(delta: float) -> void:
	for id in _timers.keys():
		var t: Dictionary = _timers[id]
		if not t["running"]:
			continue
		t["elapsed"] += delta
		var remaining: float = t["duration"] - t["elapsed"]
		emit_signal("timer_tick", id, maxf(remaining, 0.0))
		if t["elapsed"] >= t["duration"]:
			match t["mode"]:
				TimerMode.REPEAT:
					t["elapsed"] -= t["duration"]
					emit_signal("timer_finished", id)
				_:
					t["running"] = false
					t["elapsed"] = t["duration"]
					emit_signal("timer_finished", id)

func create(timer_id: String, duration: float, mode: TimerMode = TimerMode.COUNTDOWN, autostart: bool = false) -> bool:
	if _timers.size() >= MAX_TIMERS:
		push_warning("TimerManager Lite: max %d timers reached. Upgrade to PRO." % MAX_TIMERS)
		return false
	if _timers.has(timer_id):
		return false
	_timers[timer_id] = {
		"duration": duration,
		"elapsed": 0.0,
		"mode": mode,
		"running": autostart,
	}
	return true

func start(timer_id: String) -> bool:
	if not _timers.has(timer_id):
		return false
	_timers[timer_id]["running"] = true
	return true

func stop(timer_id: String) -> void:
	if _timers.has(timer_id):
		_timers[timer_id]["running"] = false

func reset(timer_id: String) -> void:
	if _timers.has(timer_id):
		_timers[timer_id]["elapsed"] = 0.0
		_timers[timer_id]["running"] = false

func restart(timer_id: String) -> void:
	if _timers.has(timer_id):
		_timers[timer_id]["elapsed"] = 0.0
		_timers[timer_id]["running"] = true

func remove(timer_id: String) -> void:
	_timers.erase(timer_id)

func is_running(timer_id: String) -> bool:
	return _timers.has(timer_id) and _timers[timer_id]["running"]

func remaining(timer_id: String) -> float:
	if not _timers.has(timer_id):
		return 0.0
	return maxf(_timers[timer_id]["duration"] - _timers[timer_id]["elapsed"], 0.0)

func elapsed(timer_id: String) -> float:
	if not _timers.has(timer_id):
		return 0.0
	return _timers[timer_id]["elapsed"]

func progress(timer_id: String) -> float:
	if not _timers.has(timer_id):
		return 0.0
	var dur: float = _timers[timer_id]["duration"]
	if dur <= 0.0:
		return 1.0
	return clampf(_timers[timer_id]["elapsed"] / dur, 0.0, 1.0)

func active_timers() -> Array:
	var result: Array = []
	for id in _timers:
		if _timers[id]["running"]:
			result.append(id)
	return result

func timer_count() -> int:
	return _timers.size()

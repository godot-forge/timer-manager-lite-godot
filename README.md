# Timer Manager Lite — Godot 4

Free named timers for Godot 4 via autoload — countdown, repeating and delay timers without spawning Timer nodes. Lite supports up to 8 timers.

## Features (Lite — Free)

- `create(id, duration, mode, autostart)` — countdown / repeating / delay
- `start(id)` / `stop(id)` / `reset(id)` / `restart(id)` / `remove(id)`
- `is_running(id)` / `remaining(id)` / `elapsed(id)` / `progress(id)`
- Signals: `timer_finished(id)`, `timer_tick(id, remaining)`
- Up to 8 timers · zero dependencies · pure GDScript autoload

## Quick Start

```gdscript
# Add addons/timer_manager_lite/timer_manager.gd as autoload named "TimerManager"
TimerManager.create("spawn", 2.0, TimerManager.TimerMode.REPEAT, true)
TimerManager.timer_finished.connect(func(id): if id == "spawn": spawn_enemy())
```

## Upgrade to PRO

[Timer Manager PRO](https://godot-forge.itch.io/timer-manager-pro-godot) adds unlimited timers, groups, pause modes, sequences and save/load.

---
Made with ♥ by [GodotForge](https://itch.io/profile/godot-forge)

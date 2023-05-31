#!/bin/sh
set -e

activeTasks="$(dbus-send --print-reply --session --dest=org.kde.ktimetracker /KTimeTracker org.kde.ktimetracker.ktimetracker.activeTasks 2>/dev/null | grep '^ *string ')"
test -n "$activeTasks"

task="$(printf '%s\n' "$activeTasks" | head -n1 | sed -e 's/^[^"]*"//' -e 's/"$//')"
num="$(printf '%s\n' "$activeTasks" | wc -l)"

if [ "$num" -gt 1 ]; then
    printf '%s (%d)\n' "$task" "$num"
else
    printf '%s\n' "$task"
fi

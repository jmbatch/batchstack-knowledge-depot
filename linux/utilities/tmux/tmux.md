# tmux Cheat Sheet

## Sessions

| Command                     | Action                      |
| --------------------------- | --------------------------- |
| `tmux new -s name`          | Start new session with name |
| `tmux ls`                   | List all sessions           |
| `tmux attach -t name`       | Attach to session           |
| `Ctrl-b d`                  | Detach from current session |
| `tmux kill-session -t name` | Kill a session              |

## Windows

| Command    | Action                |
| ---------- | --------------------- |
| `Ctrl-b c` | Create new window     |
| `Ctrl-b n` | Next window           |
| `Ctrl-b p` | Previous window       |
| `Ctrl-b w` | List/select windows   |
| `Ctrl-b ,` | Rename current window |
| `Ctrl-b &` | Close current window  |

## Panes

| Command            | Action                         |
| ------------------ | ------------------------------ |
| `Ctrl-b "`         | Split horizontally             |
| `Ctrl-b %`         | Split vertically               |
| `Ctrl-b o`         | Switch to next pane            |
| `Ctrl-b arrow key` | Move to pane in direction      |
| `Ctrl-b z`         | Zoom/unzoom pane (full screen) |
| `Ctrl-b x`         | Kill current pane              |

## Resizing Panes

| Command                    | Action            |
| -------------------------- | ----------------- |
| `Ctrl-b :resize-pane -D 5` | Resize down by 5  |
| `Ctrl-b :resize-pane -U 5` | Resize up by 5    |
| `Ctrl-b :resize-pane -L 5` | Resize left by 5  |
| `Ctrl-b :resize-pane -R 5` | Resize right by 5 |

- Many configs let you just hold Ctrl-b + arrow keys to resize directly.

## Navigation / Misc

| Command    | Action                       |
| ---------- | ---------------------------- |
| `Ctrl-b t` | Show a clock (yep, a clock)  |
| `Ctrl-b ?` | Help (shows all keybindings) |
| `Ctrl-b d` | Detach session               |
| `Ctrl-b :` | Enter command mode           |

## Muscle Memory Workflow

- Start work: `tmux new -s project`
- Split your workspace: `Ctrl-b %` then `Ctrl-b "`
- Move between panes: `Ctrl-b arrow`
- Detach to go home: `Ctrl-b d`
- Reattach: `tmux attach -t project`

# Neat lesser known CLI tools

## Searching

1. `fd` - friendlier find. defaults to sane behavior like ignoring .gitignore. colorized output.
2. `fzf` - fuzzy finder for files, history, git branches, processes
3. `broot` - tree-style directory navigator with search and file preview
4. `tldr` - community maintained examples of commands. basically man pages but condensed and handy

## File and text handling

1. `bat` - `cat` but with syntax highlighting and git integrations
2. `delta` - nice diffs in the terminal (git and `diff` replacement)
3. `jq` - JSON slicer
4. `yq` - YAML slicer
5. `sd` - a modern `sed`. Regex find/replace but simpler
6. `hyperfine` - command benchmarking (`hyperfine 'rg foo' 'grep foo').

## DevOps Helpers

1. `httpie` - human-friendly curl
2. `xh` - lightweight `httpie` alternative (written in rust)
3. `glow` - render Markdown in your terminal
4. `entr` - run a command when files change
5. `just` - a modern `make`-like task runner for project automation
6. `watchexec` - watch files and run commands

## Networking and sysadmin

1. `mtr` - dynamic traceroute + ping
2. `bmon` - real-time bandwidth monitor
3. `gping` - ping with a graph in the terminal
4. `htop` / `btop` - interactive process/system monitors
5. `ncdu` - disk usage visualizer
6. `dust` - prettier du
7. `procs` - `ps` replacement with colors and tree view
8. `dog` - modern DNS lookup tool like dig but easier to understand
9. `navi` - interactive cheatsheet tool

## Git workflow enhancers

1. `lazygit` - a TUI for git
2. `tig` - text-mode interface for git history/browsing
3. `gitui` - fast git terminal client

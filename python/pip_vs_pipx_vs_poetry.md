┌───────────────────────┬─────────────────────────────┬────────────────────────────┬─────────────────────────────┐
│        Feature        │            pip              │            pipx            │           poetry            │
├───────────────────────┼─────────────────────────────┼────────────────────────────┼─────────────────────────────┤
│ Main purpose          │ Install Python packages     │ Install/run Python CLI     │ Manage project deps, venvs, │
│                       │ into current env (project   │ tools in isolated envs     │ and packaging (uses pip)    │
│                       │ venv or global)             │                            │                             │
├───────────────────────┼─────────────────────────────┼────────────────────────────┼─────────────────────────────┤
│ Scope                 │ Project venv or global      │ Global (1 venv per tool)   │ Project-specific (auto venv)│
├───────────────────────┼─────────────────────────────┼────────────────────────────┼─────────────────────────────┤
│ Dependency isolation  │ Only in venvs               │ Always isolated per tool   │ Always isolated per project │
├───────────────────────┼─────────────────────────────┼────────────────────────────┼─────────────────────────────┤
│ Typical install       │ `pip install requests`      │ `pipx install ruff`        │ `pipx install poetry`       │
│ command               │                             │                            │ *(for Poetry itself)*       │
├───────────────────────┼─────────────────────────────┼────────────────────────────┼─────────────────────────────┤
│ How it’s run          │ Activate venv → import/use  │ CLI tool available anywhere│ Run via `poetry ...`        │
├───────────────────────┼─────────────────────────────┼────────────────────────────┼─────────────────────────────┤
│ Extras                │ Can upgrade, uninstall     │ Can run without install    │ Builds, publishes to PyPI   │
│                       │ packages                   │ (`pipx run ...`)           │ Generates pyproject.toml    │
└───────────────────────┴─────────────────────────────┴────────────────────────────┴─────────────────────────────┘

[ pipx ] installs → [ Poetry CLI ] manages → [ pip ] installs project deps

# 1️⃣ Install Poetry globally in its own venv
pipx install poetry

# 2️⃣ Create & manage a project with Poetry
poetry new myproject
cd myproject
poetry add requests
poetry run python main.py

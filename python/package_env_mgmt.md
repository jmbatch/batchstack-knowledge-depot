# Python package and environment management

## pip

- Install and manage Python packages (default in Python)

```bash
# Example
pip install requests # Install package
pip list # List installed packages
pip install -r requirements.txt # Install from file
```

## pipx

- Install & run Python CLI tools in isolated envs

```bash
# Example
pipx install black # Install tool
pipx run pycowsay moo # Run without permanent install
pipx uninstall black
```

### pipx quick install

```bash
# Gobal dev tools
pipx install poetry
pipx install ruff
pipx install black
pipx install isort
pipx install mypy
pipx install httpie
pipx install pytest
```

## poetry

- Project dependency manager + packaging

```bash
# Example
poetry new myproject # Create project
poetry add requests # Add dependency
poetry run python main.py # Run in env
poetry shell # Activate venv
```

## venv

- Built-in virtual environment manager

```bash
# Example
python -m venv venv # Create env
source venv/bin/activate / venv\Scripts\activate # Activate
deactivate
```

## conda

- Python + non-Python dependency/env manager (heavy-duty)

```bash
# Example
conda create -n myenv python=3.11
conda activate myenv
conda install numpy
```

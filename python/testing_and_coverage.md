# Testing and coverage

## pytest	
- Python testing framework	
```bash
pytest → Run tests
pytest -v → Verbose
pytest tests/test_file.py::test_func → Specific test
```

## tox
- Automate testing in multiple Python versions/envs	
```bash
tox → Run configured test environments
```

## coverage.py
- Test coverage reporting
```bash
coverage run -m pytest
coverage report -m
```
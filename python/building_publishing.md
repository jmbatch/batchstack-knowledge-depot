# Building and publishing

## build	
- PEP 517/518 package builder	
```bash
python -m build → Create dist in dist/
```

## twine	
- Upload to PyPI
```bash
twine upload dist/*
```
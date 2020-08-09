
# generate distribution files
python setup.py sdist bdist_wheel

# upload to PyPI
twine upload dist/*

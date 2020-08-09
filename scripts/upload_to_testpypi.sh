
# generate distribution files
python setup.py sdist bdist_wheel

# upload to Test PyPI
twine upload -r testpypi dist/*

# upload to PyPI
twine upload dist/*

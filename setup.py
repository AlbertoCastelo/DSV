import setuptools

with open("README.md", "r") as fh:
    long_description = fh.read()

setuptools.setup(
    name="DSGit", # Replace with your own username
    version="0.0.1",
    author="Alberto Castelo",
    author_email="alberto.castelo.becerra@gmail.com",
    description="Versioning for Data Science",
    url="https://github.com/AlbertoCastelo/DSGit",
    packages=setuptools.find_packages(),
    classifiers=[
        "Programming Language :: Python :: 3",
        "License :: OSI Approved :: MIT License",
        "Operating System :: OS Independent",
    ],
    python_requires='>=3.7',
)
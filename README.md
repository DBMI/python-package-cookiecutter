# DBMI Python Package Cookiecutter

A [cookiecutter](https://cookiecutter.readthedocs.io/en/latest/README.html) (project template) for rapidly developing new open source Python packages. Best practices with all the modern bells and whistles included. Automatically creates the project's:
* directory structure
* local git repo
* remote git repo
* GitHub pages repo.
## Features

#### Documentation

* Automatically published as [GitHub Pages](https://pages.github.com/)
* Powered by [mkdocs-material](https://github.com/squidfunk/mkdocs-material)
* Auto-generated API documentation from docstrings via [mkdocstrings](https://github.com/mkdocstrings/mkdocstrings)
* See the extensive list of [MkDocs plugins](https://github.com/mkdocs/mkdocs/wiki/MkDocs-Plugins) which can help you
 to tune the documentation to fit your project's needs

#### Changelog management

* Gently enforced: [Keep a Changelog](https://keepachangelog.com/en/1.0.0/)
* GitHub releases get their description automatically populated based on the changelog content
* The _Unreleased_ section is automatically updated when a release is done
* Changelog is embedded in the documentation

#### Bells and whistles

* [Poetry](https://python-poetry.org/docs/) for managing dependencies and packaging
* [pre-commit](https://pre-commit.com/) for running all the goodies listed below
* [mypy](https://flake8.pycqa.org/en/latest/) for static type checking
* [flake8](https://flake8.pycqa.org/en/latest/) (with multiple plugins) for linting (e.g. style and complexity checks, commented code, etc.)
* [black](https://black.readthedocs.io/en/stable/) for auto-formatting the code
* [isort](https://pycqa.github.io/isort/) for auto-sorting imports
* [autoflake](https://github.com/myint/autoflake) for auto-removing unused imports

#### Automation

* Dependency updates (via GHA workflow which creates a PR)

## Usage

1. Make sure you have [`cookiecutter`](https://cookiecutter.readthedocs.io/en/latest/installation.html).
2. Install github's command line package [gh](https://cli.github.com/).

3. ```
pip install jinja2_custom_filters_extension
```

Create a new project:

```
cookiecutter https://github.com/DBMI/python-package-cookiecutter
```

The CLI interface will ask some basic questions, such the name of the project, and then generate all the goodies
 automatically and creates the git repo, both locally and remotely (using [gh](https://cli.github.com/))

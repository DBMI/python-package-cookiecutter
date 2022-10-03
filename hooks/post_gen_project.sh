# Initialize documentation.
cd docs
sphinx-quickstart

# Initialize as git local repo.
git init
git add .
git commit -m "Initial repo" --no-verify

# Create remote repo using GitHub Command Line Interface.
gh repo create DBMI/{{cookiecutter.project_name}} --source=. --private

# Push initial code.
git push -u origin main

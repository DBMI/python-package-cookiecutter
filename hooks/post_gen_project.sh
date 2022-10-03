# Initialize documentation.
cd docs
sphinx-quickstart

# Initialize as git local repo.
cd ..
git init
git add .
git commit -m "Initial repo" --no-verify

# Create remote repo using GitHub Command Line Interface.
gh repo create DBMI/{{cookiecutter.project_name}} --source=. --private

# Push initial code.
git push -u origin main

# Initialize GitHub pages.
cd docs/build
git checkout --orphan gh-pages
git reset --hard
git commit --allow-empty -m "Init" --no-verify
git checkout develop
git worktree add html gh-pages

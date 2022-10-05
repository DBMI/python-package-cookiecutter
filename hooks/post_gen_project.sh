# Initialize documentation.
cd docs
sphinx-quickstart

# Initialize as git local repo.
echo "Creating local repo."
cd ..
git init
git add .
git commit -m "Initial repo" --no-verify

# Is GitHub Command Line Interface (CLI) installed?
if gh --version | grep -q 'version'
then
  echo "Creating remote repo."

  # Create remote repo using GitHub Command Line Interface.
  gh repo create DBMI/{{cookiecutter.project_name}} --source=. --private
else
  echo "Need to install GitHub Command Line Interface from https://github.com/cli/cli"
  exit 1
fi

# Push initial code.
echo "Pushing initial code."
git push -u origin main

# Initialize GitHub pages.
echo "Creating GitHub pages repo."
cd docs/build
git checkout --orphan gh-pages
git reset --hard
git commit --allow-empty -m "Init" --no-verify
git checkout develop
git worktree add html gh-pages

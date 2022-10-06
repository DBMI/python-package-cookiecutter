#!/bin/sh

# Initialize documentation.
cd docs
pip install sphinx
sphinx-quickstart --quiet -p "{{ cookiecutter.project_slug }}" -a "{{ cookiecutter.author_name }}" -v 0.0.1

# Initialize as git local repo.
echo "Creating local repo."
cd ..
git init
git add .
git commit -m "Initial repo" --no-verify
git branch -M main

# Is GitHub Command Line Interface (CLI) installed?
if gh --version | grep -q 'version' 
then
  # Create remote repo using GitHub Command Line Interface.
  repo_name="DBMI/{{ cookiecutter.project_slug }}"
  echo "Creating remote repo ${repo_name}."
  sleep 2.5s
  gh repo create ${repo_name} --source=. --private --remote=upstream
else
  echo "Need to install GitHub Command Line Interface from https://github.com/cli/cli"
  read -p 'Exiting. Press any key.'
  exit 1
fi

# Push initial code.
echo "Pushing local code to remote repo."
sleep 2.5s
git push -u upstream main

read -p 'Ready to create GitHub pages. Press any key.'

# Initialize GitHub pages.
echo "Creating GitHub pages repo."
cd docs/build
mkdir html
git checkout --orphan gh-pages
git reset --hard
git commit --allow-empty -m "Initialize" --no-verify
git checkout -b develop main
rm -rf html
git worktree add html gh-pages
cd html
git add --all
git commit --allow-empty -m "Initialize GitHub pages" --no-verify
git push upstream gh-pages
git checkout develop
git pull
read -p 'Project setup complete. Press any key.'

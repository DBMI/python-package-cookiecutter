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
sleep 2.5s

# Is GitHub Command Line Interface (CLI) installed?
if gh --version | grep -q 'version' 
then
  # Create remote repo using GitHub Command Line Interface.
  repo_name="DBMI/{{ cookiecutter.project_slug }}"
  echo "Creating remote repo ${repo_name}."
  gh repo create ${repo_name} --source=. --private
  
  git_name="https://github.com/${repo_name}.git"
  echo "Setting ${git_name} as remote origin."
  git remote add origin ${git_name}
else
  echo "Need to install GitHub Command Line Interface from https://github.com/cli/cli"
  read -p 'Exiting. Press any key.'
  exit 1
fi

sleep 2.5s

# Push initial code.
echo "Pushing local code to remote repo."
git push -u origin main

read -p 'Ready to create GitHub pages. Press any key.'

# Initialize GitHub pages.
echo "Creating GitHub pages repo."
cd docs/build
echo "About to checkout gh-pages branch."
git checkout --orphan gh-pages
echo "About to reset."
git reset --hard
echo "About to commit to gh-pages."
git commit --allow-empty -m "Init" --no-verify
echo "About to checkout develop branch."
git checkout -b develop
# git worktree add html gh-pages

read -p 'Project setup complete. Press any key.'

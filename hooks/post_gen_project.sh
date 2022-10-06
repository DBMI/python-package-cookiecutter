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

read -p 'Ready to create remote repo. Press any key.' input_key

# Is GitHub Command Line Interface (CLI) installed?
if gh --version | grep -q 'version' then
  echo "Forming repo name."
  # Create remote repo using GitHub Command Line Interface.
  repo_name="DBMI/{{ cookiecutter.project_slug }}"
  echo "Creating remote repo ${repo_name}."
  gh repo create ${repo_name} --source=. --private
  
  git_name="https://github.com/${repo_name}.git"
  echo "Setting ${git_name} as remote origin."
  git remote add origin ${git_name}
else
  echo "Need to install GitHub Command Line Interface from https://github.com/cli/cli"
  read -p 'Exiting. Press any key.' input_key
  exit 1
fi

read -p 'Ready to push code to remote repo. Press any key.' input_key

# Push initial code.
echo "Pushing initial code."
git push -u origin main

read -p 'Ready to create GitHub pages. Press any key.' input_key

# Initialize GitHub pages.
echo "Creating GitHub pages repo."
cd docs/build
git checkout --orphan gh-pages
git reset --hard
git commit --allow-empty -m "Init" --no-verify
git checkout develop
git worktree add html gh-pages

read -p 'Project setup complete. Press any key.' input_key

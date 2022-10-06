#!/bin/sh

# Initialize documentation.
echo "*******************************************"
echo "* Initializing documentation with sphinx. *"
echo "*******************************************"
cd docs
pip install sphinx
sphinx-quickstart --quiet -p "{{ cookiecutter.project_slug }}" -a "{{ cookiecutter.author_name }}" -v 0.0.1

# Initialize as git local repo.
echo "*******************************************"
echo "*          Creating local repo.           *"
echo "*******************************************"
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
  echo "*******************************************"
  echo "Creating remote repo ${repo_name}."
  echo "*******************************************"
  sleep 2.5s
  gh repo create ${repo_name} --source=. --private --remote=upstream
else
  echo "*******************************************"
  echo "Need to install GitHub Command Line Interface from https://github.com/cli/cli"
  echo "*******************************************"
  read -p 'Exiting. Press any key.'
  exit 1
fi

# Push initial code.
echo "*******************************************"
echo "*   Pushing local code to remote repo.    *"
echo "*******************************************"
sleep 2.5s
git push -u upstream main

# Initialize GitHub pages.
echo "*******************************************"
echo "*      Creating GitHub pages repo.        *"
echo "*******************************************"
cd docs/build
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

# Create develop branch in the remote repo.
cd ../..
git pull
git push upstream develop:develop

echo "*******************************************"
echo "*       Project setup complete.           *"
echo "*******************************************"
read -p 'Press any key.'


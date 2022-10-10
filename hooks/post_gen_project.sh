#!/bin/sh

# Initialize documentation.
echo "**********************************************"
echo "*  Initializing documentation with sphinx.   *"
echo "**********************************************"
cd docs
pip install sphinx
sphinx-quickstart --quiet -p "{{ cookiecutter.project_slug }}" -a "{{ cookiecutter.author_name }}" -v 0.0.1
cd ..

# Mark the last-commit badge with today's date.
echo "**********************************************"
echo "* Setting today's date on last-commit badge. *"
echo "**********************************************"
pip install anybadge
TODAY=$(date +"%B %d, %Y")
anybadge -l "last commit" -v "$TODAY" --overwrite --file .\\.github\\badges\\last-commit-badge.svg

# Initialize as git local repo.
echo "**********************************************"
echo "*            Creating local repo.            *"
echo "**********************************************"
git init
git add .
git commit -m "Initial repo" --no-verify
git branch -M main

# Is GitHub Command Line Interface (CLI) installed?
if gh --version | grep -q 'version' 
then
  # Create remote repo using GitHub Command Line Interface.
  repo_name="DBMI/{{ cookiecutter.project_slug }}"
  echo "**********************************************"
  echo "Creating remote repo ${repo_name}."
  echo "**********************************************"
  sleep 2.5s
  gh repo create ${repo_name} --source=. --private --remote=upstream
  # Have local repo track the remote.
  git remote add origin ${repo_name}
else
  echo "**********************************************"
  echo "Need to install GitHub Command Line Interface from https://github.com/cli/cli"
  echo "**********************************************"
  read -p 'Exiting. Press any key.'
  exit 1
fi

# Push initial code.
echo "**********************************************"
echo "*     Pushing local code to remote repo.     *"
echo "**********************************************"
sleep 2.5s
git push -u upstream main

# Initialize GitHub pages.
echo "**********************************************"
echo "*        Creating GitHub pages repo.         *"
echo "**********************************************"
sleep 2.5s
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
echo "**********************************************"
echo "*  Creating develop branch in remote repo.   *"
echo "**********************************************"
sleep 2.5s
cd ../../..
git pull upstream main
git push upstream develop:develop

echo "**********************************************"
echo "*          Project setup complete.           *"
echo "**********************************************"
read -p 'Press any key.'


TODAY=$(date +"%B %d, %Y")
.\\venv\\Scripts\\anybadge -l "last commit" -v "$TODAY" --overwrite --file .\\.github\\badges\\last-commit-badge.svg

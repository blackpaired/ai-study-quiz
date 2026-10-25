#!/usr/bin/env bash
# Installs the study-quiz skill for your terminal AI agent.
# Usage: open a terminal in this folder and run
#   bash install.sh [skills-folder]
# Default: ~/.claude/skills (a skills folder several AI tools read).
# Pass the folder your AI tool loads skills from to install somewhere else.
set -euo pipefail
here="$(cd "$(dirname "$0")" && pwd)"
skills="${1:-$HOME/.claude/skills}"

mkdir -p "$skills"
rm -rf "$skills/study-quiz"
cp -r "$here/skills/study-quiz" "$skills/"
chmod +x "$skills/study-quiz/to_md.sh"

echo "Skill installed:  $skills/study-quiz/"
echo
echo "Required programs:"
missing=0
check() { if command -v "$1" >/dev/null 2>&1; then echo "  ok       $1"; else echo "  MISSING  $1  ($2)"; missing=1; fi; }
check markitdown  "pip install 'markitdown[all]'  or  pipx install 'markitdown[all]'"
check pdftotext   "poppler: sudo pacman -S poppler / sudo apt install poppler-utils / brew install poppler"
check pdftoppm    "poppler (see above)"
check pandoc      "optional fallback for Word files: sudo pacman -S pandoc / sudo apt install pandoc / brew install pandoc"
check tesseract   "optional, for scans: tesseract + language packs"

echo
[ "$missing" = 0 ] && echo "All set!" || echo "Please install the missing programs (see above). Optional ones can be skipped."
echo "Then (re)start your AI agent and type  /study-quiz <folder>"
echo "(or just ask: \"quiz me on <folder>\")"

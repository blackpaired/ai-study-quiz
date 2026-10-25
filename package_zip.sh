#!/usr/bin/env bash
# Builds dist/study-quiz.zip for AI apps that let you upload skills as a ZIP file.
# Some apps allow at most 200 characters in the skill description, so the ZIP gets this short one;
# the full SKILL.md description stays in the repo.
set -euo pipefail
here="$(cd "$(dirname "$0")" && pwd)"
short="Quizzes you on your lecture notes like an oral examiner: one question at a time, detailed follow-ups, honest grading against your notes. Use for quiz me or exam practice."
[ ${#short} -le 200 ] || { echo "Short description is ${#short} characters (max 200)" >&2; exit 1; }
work="$(mktemp -d)"
trap 'rm -rf "$work"' EXIT
cp -r "$here/skills/study-quiz" "$work/study-quiz"
rm -rf "$work/study-quiz/template" "$work/study-quiz/__pycache__"

SHORT="$short" python3 -I - "$work/study-quiz/SKILL.md" <<'PY'
import os, re, sys
p = sys.argv[1]
s = open(p, encoding="utf-8").read()
s, n = re.subn(r"^description: .*$", lambda m: "description: " + os.environ["SHORT"], s, count=1, flags=re.M)
assert n == 1, "no description line found"
open(p, "w", encoding="utf-8").write(s)
PY
mkdir -p "$here/dist"
rm -f "$here/dist/study-quiz.zip"
python3 -I -c 'import shutil, sys; shutil.make_archive(sys.argv[1], "zip", sys.argv[2], sys.argv[3])' "$here/dist/study-quiz" "$work" "study-quiz"
echo "Built: $here/dist/study-quiz.zip"

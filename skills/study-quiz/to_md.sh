#!/usr/bin/env bash
# Converts all study materials in a folder (or single files) to Markdown.
# Usage:  to_md.sh <folder-or-file> [more ...]
# - Originals are never changed; the .md is written next to them (same name, .md extension).
# - Existing .md files are skipped.
# - Reports files that are probably scans (almost no text) -> the AI has to look at the pages as images / run OCR.
set -uo pipefail

if [ $# -eq 0 ]; then
  echo "Usage: $0 <folder-or-file> [more ...]" >&2
  exit 1
fi
if ! command -v markitdown >/dev/null 2>&1; then
  echo "markitdown is missing: pipx install 'markitdown[all]'" >&2
  exit 1
fi

files=()
for p in "$@"; do
  if [ -d "$p" ]; then
    while IFS= read -r -d '' f; do files+=("$f"); done < <(
      find "$p" -maxdepth 2 -type f \( -iname '*.pdf' -o -iname '*.docx' -o -iname '*.doc' \
        -o -iname '*.pptx' -o -iname '*.ppt' -o -iname '*.xlsx' -o -iname '*.odt' \
        -o -iname '*.html' -o -iname '*.txt' -o -iname '*.rtf' -o -iname '*.epub' \) -print0 | sort -z)
  elif [ -f "$p" ]; then
    files+=("$p")
  else
    echo "not found: $p" >&2
  fi
done

scans=()
for f in "${files[@]}"; do
  out="${f%.*}.md"
  if [ -f "$out" ] && [ -s "$out" ]; then
    echo "• exists:     $out"
  elif markitdown "$f" -o "$out" 2>/dev/null && { [ -s "$out" ] || [[ "${f,,}" == *.pdf ]]; }; then
    echo "converted:  $out"
  elif command -v pandoc >/dev/null 2>&1 && [[ "${f,,}" =~ \.(docx|odt|html|epub|rtf)$ ]] \
       && pandoc "$f" -t gfm --wrap=none -o "$out" 2>/dev/null; then
    echo "converted (pandoc): $out"
  else
    rm -f "$out"
    echo "FAILED:     $f   (maybe missing: pipx install --force 'markitdown[all]')"
    continue
  fi
  # PDFs with less than ~200 characters per page -> probably a scan
  if [[ "${f,,}" == *.pdf ]]; then
    chars=$(tr -d '[:space:]' < "$out" | wc -c)
    pages=$(pdfinfo "$f" 2>/dev/null | awk '/^Pages:/{print $2}')
    pages=${pages:-1}
    if [ "$chars" -lt $((pages * 200)) ]; then scans+=("$f ($pages pages, $chars characters)"); fi
  fi
done

if [ ${#scans[@]} -gt 0 ]; then
  echo
  echo "! Probably scans (hardly any text found) – look at the pages as images or run OCR:"
  for s in "${scans[@]}"; do echo "  - $s"; done
fi

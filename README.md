# AI Study Quiz

A skill for **terminal AI agents** (AI coding agents / agentic CLIs such as Claude Code, Codex CLI, Gemini CLI, OpenCode …) that quizzes you on your study materials (PDFs, lecture notes, slides, even scans) like a good **oral examiner**. It doesn't just check whether you know the facts. It checks whether you **understood** them: why, what happens if, how it applies to a real case.

## What you get

- **One question at a time**, answered freely in your own words. No multiple choice.
- **Honest grading** against your materials: correct / partly / wrong, what was right, what was missing, with the location in your notes.
- **Detailed follow-up questions**: "why?", "what happens if …?", differences, step-by-step processes, cases, "spot the mistake", "explain it to a patient".
- **Discussion** when you don't know something: a short explanation with the *why*, then a check question to make sure it sits.
- **Hint ladder** instead of instant answers: small hint → bigger hint → answer.
- **Repetition**: everything you got wrong comes back later in the session, phrased differently.
- **It keeps going** until you say *stop*.
- **Quiz log** (`<Material>_Quiz-Log.md`) with your weak spots, so the next session starts exactly there.
- **Automatic conversion** of your materials to Markdown (`to_md.sh`), including detection of scanned PDFs.

## Example

See [`examples/example-session.md`](examples/example-session.md) for a shortened example session: questions, grading, a hint, follow-ups, the wrap-up and the quiz log it writes.

## How it works

1. **Convert:** all files in your folder are converted to `.md` with `markitdown` (fallback: `pandoc` for Word files). For scanned pages, the AI looks at rendered page images directly or runs OCR.
2. **Read:** the AI reads all of the material and builds an internal map of exam-relevant points, connections and things that are easily confused.
3. **Quiz:** one question → your answer → grading → follow-ups → discussion → next topic. As long as you want.
4. **Log:** when you say *stop*, you get a short evaluation and the log is written or updated next to your materials.

## Requirements

- A terminal AI agent that can read files and run shell commands. Skill support is a plus, but not required.
- Linux or macOS (Windows via WSL)
- [`markitdown`](https://github.com/microsoft/markitdown): `pipx install 'markitdown[all]'`
- `poppler`: `sudo pacman -S poppler` / `sudo apt install poppler-utils` / `brew install poppler`
- Optional: [`pandoc`](https://pandoc.org) (fallback for Word files), `tesseract` plus the language packs you need (for scans)

## Installation

```bash
git clone https://github.com/blackpaired/ai-study-quiz.git
cd ai-study-quiz
bash install.sh
```

By default the script copies the skill to `~/.claude/skills/study-quiz/`, a folder several AI tools read skills from (`SKILL.md` is an open format used by many AI agents). If your AI tool loads skills from a different folder, pass it:

```bash
bash install.sh ~/.my-ai-tool/skills
```

The script also shows which required programs are missing.

To install by hand instead:

```bash
mkdir -p <skills-folder>
cp -r skills/study-quiz <skills-folder>/
chmod +x <skills-folder>/study-quiz/to_md.sh
```

Then restart your AI agent.

**Tool without skill support?** It still works: tell the AI *"follow the instructions in `<skills-folder>/study-quiz/SKILL.md` for ~/Documents/Physiology/"*.

## Use in AI chat apps

Some AI chat apps (web or desktop) let you upload skills in the `SKILL.md` format as a ZIP file:

1. Download **`study-quiz.zip`** from the [latest release](https://github.com/blackpaired/ai-study-quiz/releases/latest).
2. Upload it in your app's skill settings.
3. Make sure the app lets the AI run code and create files.
4. Upload your lecture notes in a chat and ask, e.g., *"quiz me on these notes"*.

The quiz log can't be saved between chats there: download it at the end and upload it again next time, so the quiz starts with your weak spots.

Some apps allow only 200 characters for a skill description, so the ZIP has a shorter one. To build the ZIP yourself: `bash package_zip.sh` (creates `dist/study-quiz.zip`).

## Usage

Put the materials for one exam into one folder, then in your AI agent type:

```
/study-quiz ~/Documents/Physiology/
```

Plain language works too: *"quiz me on ~/Documents/Physiology"*, or *"quiz me, but only on chapter 3"*.

The quiz runs in the language you write in. If your materials are in a different language, it asks you at the start which language you want.

### Commands during the quiz

| Say | What happens |
|---|---|
| `hint` / `no idea` | next step of the hint ladder |
| `answer` | the answer with explanation, then a check question |
| `skip` | topic is marked as open, next topic |
| `easier` / `harder` | difficulty is adapted |
| `status` | interim summary and honest feedback on your answers so far |
| `only chapter X` | only questions about that part |
| `stop` | evaluation + quiz log |

### Converting only

```bash
<skills-folder>/study-quiz/to_md.sh ~/Documents/Physiology/
```

## Works well with

- [ai-study-notes](https://github.com/blackpaired/ai-study-notes): turns your materials into study notes that explain the connections, exported as a PDF.
- [ai-study-tutor](https://github.com/blackpaired/ai-study-tutor): teaches you the material step by step before you get quizzed.

- [ai-study-anki](https://github.com/blackpaired/ai-study-anki): turns your materials into Anki flashcards (CSV, one-click import).

## Important

- Grading is based on your materials. Explanations partly come from general knowledge. **If anything contradicts your lecture or textbook, your lecture wins.**
- The AI can make mistakes. If a grading looks wrong to you, say so and ask for the location in your notes.
- Every session uses your AI usage (tokens / plan limits). Long quizzes and large materials mean more usage.

---

*This repo was created with the help of Claude Opus 5.5.*

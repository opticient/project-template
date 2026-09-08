# Project Template

Starting point for opticient projects. Click **Use this template**, then:

- Rename `name` in `pyproject.toml`
- Rewrite this README and the Project section of `AGENTS.md`
- Pick unused ports in `.env.example`
- Set the `PR_REVIEWER` repo variable to the other person's username

## Setup

```sh
cp .env.example .env
uv sync --all-groups
uv run pre-commit install --install-hooks
uv run pre-commit install --hook-type commit-msg
git config commit.template .gitmessage
docker compose up -d
```

Requires Docker, [uv](https://docs.astral.sh/uv/), and Python 3.12.

The hooks run lint, formatting, type checks, secret detection and
commit-message rules before every commit.

## Ports

| Ports | Used by |
|-------|---------|
| 5440, 6379 | work stack — do not use |
| 5433, 6380 | personal shared stack |
| 5434, 6381 | template defaults — change per project |

## Commands

| Command | Does |
|---------|------|
| `docker compose up -d` | Start services |
| `docker compose down` | Stop services, keep data |
| `docker compose down -v` | Stop services and delete all data |
| `uv run pytest` | Tests with coverage |
| `uv run ruff check .` | Lint |
| `uv run ruff format .` | Format |
| `uv run mypy src` | Type check |
| `uv run pre-commit run --all-files` | Every hook on every file |

## Pre-commit hooks

Install once per clone. Two installs are needed: one for the code hooks, one for
the commit-message hook.

```sh
uv run pre-commit install --install-hooks
uv run pre-commit install --hook-type commit-msg
```

Verify:

```sh
uv run pre-commit run --all-files
```

What runs on every commit:

| Hook | Blocks |
|------|--------|
| `ruff-check` | lint errors, with autofix |
| `ruff-format` | unformatted code |
| `mypy` | type errors |
| `detect-private-key` | a committed private key |
| `detect-aws-credentials` | committed AWS keys |
| `check-added-large-files` | anything over 5 MB |
| `debug-statements` | a forgotten `breakpoint()` |
| `check-json` / `check-yaml` / `check-toml` | malformed config |
| `check-merge-conflict` | conflict markers |
| `end-of-file-fixer` / `trailing-whitespace` | whitespace noise |
| `conventional-pre-commit` | a commit message that breaks the format |
| `pytest` | failing tests |

`fail_fast: true`, so the run stops at the first failure. Never bypass with
`--no-verify` — the secret checks are the reason these exist on a public repo.

## Branches

`main` and `staging` are both protected and reject direct pushes.

```
as/feat/thing  ->  PR  ->  staging  ->  PR  ->  main
```

```sh
git switch -c as/feat/thing
git push
```

Pushing a branch opens one PR to `staging` automatically. If a PR is already
open for that branch, later pushes do not open another. The `staging` to `main`
release PR is opened by hand.

## Commits

Conventional Commits, enforced by a `commit-msg` hook.

```
feat(retrieval): add hybrid search
fix(api): handle empty query
```

Types: feat fix docs style refactor perf test build ci chore revert

## Rules

`rules/` is the source of truth for engineering standards. Editing a file there
and running the sync script regenerates every AI tool's config from it:

```sh
./scripts/sync-rules.sh
```

That writes `AGENTS.md`, `CLAUDE.md`, `.github/copilot-instructions.md`,
`.cursor/rules/*.mdc` and `.windsurfrules`. Never edit those by hand — the
generated block is replaced on every run. Project-specific notes go *above* the
`BEGIN GENERATED RULES` marker and are preserved.

| File | Covers |
|------|--------|
| `conventional-commits.md` | Commit message format, enforced by a hook |
| `git-workflow.md` | Branches, PR flow, review expectations |
| `python.md` | Version, Ruff, imports, types, errors, naming |
| `testing.md` | pytest conventions, isolation, coverage |
| `pre-commit-hooks.md` | Which hooks run and why |
| `structured-logging.md` | structlog usage, levels, redaction |
| `secrets-and-public-repos.md` | What must never be committed |
| `ml-projects.md` | Reproducibility, evaluation, serving, LLM providers |
| `code-structure.md` | Where code belongs |

## Secrets

Real values go in `.env`, which is gitignored. Never commit a key — repos are
public and git history is permanent.

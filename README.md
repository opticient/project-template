# Project Template

Starting point for opticient projects. Click **Use this template**, then:

- Rename `name` in `pyproject.toml`
- Rewrite this README and the Project section of `AGENTS.md`
- Pick unused ports in `.env.example`
- Set the `PR_REVIEWER` repo variable to the other person's username

## Setup

```sh
cp .env.example .env
make setup
make test
```

Requires Docker, [uv](https://docs.astral.sh/uv/), and Python 3.12.

`make setup` also installs the pre-commit hooks, so lint, formatting, type
checks, secret detection and commit-message rules run before every commit.

## Ports

| Ports | Used by |
|-------|---------|
| 5440, 6379 | work stack — do not use |
| 5433, 6380 | personal shared stack |
| 5434, 6381 | template defaults — change per project |

## Commands

| Command | Does |
|---------|------|
| `make setup` | First-time setup |
| `make up` / `make down` | Start / stop services |
| `make test` | Tests with coverage |
| `make lint` | Ruff, format check, mypy |
| `make fmt` | Auto-format and fix |
| `make hooks` | Run every pre-commit hook on all files |
| `make clean` | Stop services and delete all data |

## Branches

`main` and `staging` are both protected and reject direct pushes.

```
feat/thing  ->  PR  ->  staging  ->  PR  ->  main
```

```sh
git switch -c feat/thing
git push
```

Pushing a branch opens a PR to `staging` automatically and requests review from
the other person. Merging into `staging` opens a release PR to `main`. Every PR
needs one approval.

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

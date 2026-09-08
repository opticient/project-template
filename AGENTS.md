# Agent instructions

## Project

Replace this section with what the project does and how it is structured.

## Rules

- Python 3.12+, managed with `uv`. Never call `pip` directly.
- Type hints on every function signature. Pydantic v2 for validation and settings.
- `structlog` for logging with keyword context. Never `print()` or stdlib `logging`.
- Ruff for lint and format: line-length 100, double quotes, single-line imports.
- Tests with pytest, named `test_should_<behavior>_when_<condition>`.
- Do not add explanatory comments to code that is already clear.

## Branches

`main` and `staging` are protected. Work on a feature branch; pushing it opens a
PR to `staging` automatically.

```
feat/thing  ->  PR  ->  staging  ->  PR  ->  main
```

## Commits

Conventional Commits, enforced by a `commit-msg` hook.

```
<type>(scope): description
```

Types: feat fix docs style refactor perf test build ci chore revert

## Never

- Commit `.env`, keys, tokens, datasets, or model weights. Repos are public.
- Bypass hooks with `--no-verify`.
- Push directly to `main` or `staging`.

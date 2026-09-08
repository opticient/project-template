## What this changes

## Why

## How to verify

```sh
uv run pytest
uv run ruff check .
uv run mypy src
```

## Checklist

- [ ] Tests pass locally
- [ ] Lint and type checks pass
- [ ] No secrets, keys, datasets or model weights committed
- [ ] Rules changed? Ran `./scripts/sync-rules.sh` and committed the generated files
- [ ] README updated if setup changed

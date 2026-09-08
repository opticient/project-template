.PHONY: setup up down logs test lint fmt hooks clean

setup:
	@test -f .env || cp .env.example .env
	uv sync --all-groups
	uv run pre-commit install --install-hooks
	uv run pre-commit install --hook-type commit-msg
	git config commit.template .gitmessage
	docker compose up -d

up:
	docker compose up -d

down:
	docker compose down

logs:
	docker compose logs -f

test:
	uv run pytest

lint:
	uv run ruff check .
	uv run ruff format --check .
	uv run mypy src

fmt:
	uv run ruff format .
	uv run ruff check --fix .

hooks:
	uv run pre-commit run --all-files

clean:
	docker compose down -v

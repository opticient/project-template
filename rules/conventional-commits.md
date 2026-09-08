# Conventional Commits

## Format

- DO: Use `<type>(scope): description`
- DO: Keep the header under 100 characters
- DO: Use lowercase for type and scope
- DO: Write the description in imperative mood ("add feature", not "added feature")
- DO: Leave a blank line before the body and before the footer
- DON'T: End the subject line with a period
- DON'T: Capitalize the first word of the description
- DON'T: Leave the type empty

## Types

- DO: Use only these: feat, fix, docs, style, refactor, perf, test, build, ci, chore, revert
- DO: Use `feat` for new behavior a user can see
- DO: Use `fix` for bug fixes
- DO: Use `refactor` for changes that neither fix a bug nor add a feature
- DO: Use `perf` for performance work
- DO: Use `test` for adding or correcting tests
- DO: Use `build` for dependency or build system changes
- DO: Use `ci` for pipeline changes
- DO: Use `chore` for maintenance with no production code change
- DO: Use `docs` for documentation-only changes

## Scopes

- DO: Use the module or feature name as scope (`retrieval`, `api`, `ingest`, `eval`)
- DON'T: Omit the scope unless the change is genuinely global

## Breaking changes

- DO: Add `!` after the type or scope (`feat(api)!: drop v1 endpoints`)
- DO: Include a `BREAKING CHANGE:` footer explaining the migration
- DON'T: Ship a breaking change with only one of the two

## Tooling

- DO: Let the `commit-msg` hook validate the message
- DON'T: Bypass validation with `--no-verify`

# Code Structure

- DO: Keep `src/` for library and application code, `tests/` for tests, `scripts/` for one-off entry points
- DO: Keep route and CLI handlers thin; put logic in service modules
- DO: Group by feature rather than by layer once a project outgrows a handful of modules
- DO: Read configuration once, through a Pydantic settings object
- DON'T: Read environment variables scattered through the codebase
- DON'T: Put business logic in serializers, schemas or views

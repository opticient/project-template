# Testing

## General

- DO: Use pytest, not unittest
- DO: Name test files `test_*.py` and test functions `test_should_<behavior>_when_<condition>`
- DO: Use PascalCase `Test*` for test classes
- DO: Follow Arrange-Act-Assert in every test
- DO: Test one behavior per test
- DO: Set `pythonpath = ["."]` in the pytest configuration
- DON'T: Share mutable state between tests
- DON'T: Write tests that depend on execution order
- DON'T: Commit `.skip` without a linked issue

## Isolation

- DO: Mock external HTTP, database and AI provider calls in unit tests
- DO: Use a disposable database for integration tests
- DON'T: Call a real LLM or embedding API in automated tests — it costs money and is non-deterministic
- DON'T: Run tests against a production or shared database

## Coverage

- DO: Enable branch coverage
- DO: Treat a coverage drop as a blocking review comment
- DON'T: Write assertions-free tests to inflate the number

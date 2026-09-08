# ML and Data Projects

## Reproducibility

- DO: Set and record a random seed for every training or evaluation run
- DO: Record dataset version, model version, hyperparameters and metrics for each run
- DO: Pin dependency versions in the lockfile
- DON'T: Report a metric that cannot be reproduced from what is committed

## Structure

- DO: Keep notebooks for exploration only; move anything reused into `src/`
- DO: Separate data loading, feature engineering, training and inference into distinct modules
- DO: Make training runnable from the command line, not only from a notebook
- DON'T: Import from a notebook in application code

## Evaluation

- DO: Fix the train, validation and test split before looking at results
- DO: Report the baseline alongside the model — a number without a baseline says nothing
- DO: Report latency and cost next to quality metrics
- DO: Use Recall@K, MRR and NDCG for retrieval; state K explicitly
- DON'T: Tune against the test set
- DON'T: Compare runs that used different splits or preprocessing

## Serving

- DO: Load the model once at startup, not per request
- DO: Validate inputs with Pydantic before they reach the model
- DO: Return a version identifier with every prediction
- DON'T: Block the event loop with synchronous inference in an async handler

## LLM providers

- DO: Access providers through one interface so the backend can be swapped
- DO: Read provider, model and key from configuration
- DO: Set explicit timeouts and retry limits on every provider call
- DON'T: Hardcode a provider or model name in application code
- DON'T: Call a paid API from a test

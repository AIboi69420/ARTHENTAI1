#!/bin/bash

# Activate any virtual env if needed (optional)
# source /path/to/venv/bin/activate

# Run the FastAPI app with uvicorn, tuned for production readiness
uvicorn main:app --host 0.0.0.0 --port 8000 --workers 1 --timeout-keep-alive 120

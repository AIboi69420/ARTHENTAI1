#!/bin/bash
set -e

# Start the FastAPI app with Uvicorn on port 8000, listening on all interfaces
uvicorn main:app --host 0.0.0.0 --port 8000

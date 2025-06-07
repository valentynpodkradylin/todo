.PHONY: help install run dev clean 
# test  lint format check

HOST ?= 0.0.0.0
PORT ?= 8000

# Default target
help:
	@echo "Available commands:"
	@echo "  install    - Install dependencies using uv"
	@echo "  run        - Run the FastAPI application in production mode"
	@echo "  dev        - Run the FastAPI application in development mode with auto-reload"
	@echo "  clean      - Clean cache and temporary files"
	# @echo "  test       - Run tests (if any)"
	# @echo "  lint       - Run linting checks"
	# @echo "  format     - Format code"
	# @echo "  check      - Run all checks (lint + format check)"
	# @echo "  sync       - Sync dependencies with lock file"

# Install dependencies
install:
	uv sync

# Sync dependencies with lock file
sync:
	uv sync

# Run the application in production mode
run:
	uv run uvicorn src.main:app --host $(HOST) --port $(POST)

# Run the application in development mode with auto-reload
dev:
	uv run uvicorn src.main:app --host $(HOST) --port $(POST) --reload

# *  # Run tests
# test:
# 	uv run pytest -v

# * # Run linting checks
# lint:
# 	uv run ruff check .

# * # Format code
# format:
# 	uv run ruff format .

# * #Fix linting issues automatically
# fix:
# 	uv run ruff check . --fix

# * #Run all checks
# check: lint
# 	uv run ruff format --check .

# Clean cache and temporary files
clean:
	find . -type d -name "__pycache__" -exec rm -rf {} + 2>/dev/null || true
	find . -type d -name "*.egg-info" -exec rm -rf {} + 2>/dev/null || true
	find . -type f -name "*.pyc" -delete 2>/dev/null || true
	find . -type f -name "*.pyo" -delete 2>/dev/null || true

# Add development dependencies
add-dev-deps:
	uv add --dev pytest ruff

# Show project info
info:
	@echo "Project: $(shell grep '^name = ' pyproject.toml | cut -d'"' -f2)"
	@echo "Version: $(shell grep '^version = ' pyproject.toml | cut -d'"' -f2)"
	@echo "Python: $(shell uv run python --version)"
	@echo "FastAPI available at: http://localhost:$(POST)"
	@echo "API docs at: http://localhost:$(POST)/docs"

# Build for deployment
build:
	uv build 
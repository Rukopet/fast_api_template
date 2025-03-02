VIRTUAL_ENV ?= .venv
PYTHON_VERSION ?= 3.12
PYTHON_VERSION_FILE ?= .python-version
PYTHONPATH ?= .
PERCENT_COVERAGE ?= 100
WORKERS ?= auto
DOCKER_IMAGE_NAME ?= fast_api_template
.PHONY: help lint format test test-ci clean re

.DEFAULT_GOAL := help


help:
	@echo "Available commands:"
	@echo "  install      - Install dependencies"
	@echo "  lint         - Run code linting"
	@echo "  format       - Format code"
	@echo "  test         - Run tests with coverage"
	@echo "  test-ci      - Run tests in CI environment"
	@echo "  clean        - Clean temporary files"
	@echo "  re           - Reinstall dependencies and run tests"

$(VIRTUAL_ENV):
	uv venv

$(PYTHON_VERSION_FILE): | $(VIRTUAL_ENV)
	uv python install $(PYTHON_VERSION)
	uv python pin $(PYTHON_VERSION)

.deps: pyproject.toml $(PYTHON_VERSION_FILE)
	uv sync --all-extras --dev
	pre-commit install --install-hooks
	@touch .deps

install: .deps
	@printf "\nSetup complete! To activate the virtual environment, run:\n\n    source $(VIRTUAL_ENV)/bin/activate\n"

lint:
	uv pip install ruff
	ruff check .
	ruff format --check .

format:
	ruff check --fix .
	ruff format .

build-image:
	docker buildx build \
		--file Dockerfile \
		--tag $(DOCKER_IMAGE_NAME) \
		--progress=plain \
		--output type=docker .

test:
	docker run --rm $(DOCKER_IMAGE_NAME) \
		sh -c "rm -rf coverage && \
		uv run coverage run -m pytest -v -p no:warnings /app && \
		uv run coverage combine && \
		uv run coverage report --fail-under=$(PERCENT_COVERAGE) --format=xml"

test_without_coverage:
	rm -rf coverage; \
	uv run coverage run -m pytest -v -p no:warnings .;

clean:
	uv python uninstall $(PYTHON_VERSION)
	rm -rf .pytest_cache .ruff_cache .coverage coverage dist *.egg-info .deps .python-version uv.lock
	find . -type d -name __pycache__ -exec rm -rf {} +
	find . -type f -name "*.pyc" -delete

re: clean install test_without_coverage

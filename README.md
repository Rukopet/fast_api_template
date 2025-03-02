# FastAPI Template

Modern template for creating APIs with FastAPI, SQLAlchemy, Pydantic, and other modern Python tools.

## Features

- 🚀 [FastAPI](https://fastapi.tiangolo.com/) for creating high-performance APIs
- 🔍 Strong typing with [Pydantic](https://docs.pydantic.dev/)
- 🗃️ ORM with [SQLAlchemy](https://www.sqlalchemy.org/)
- 🔄 Database migrations with [Alembic](https://alembic.sqlalchemy.org/)
- 🧪 Testing with [pytest](https://docs.pytest.org/)
- 🧹 Linting and formatting with [Ruff](https://github.com/astral-sh/ruff)
- 🔒 Static type checking with [mypy](https://mypy.readthedocs.io/)
- 🔄 Dependency management with [UV](https://github.com/astral-sh/uv)
- 🚫 Pre-commit checks with [pre-commit](https://pre-commit.com/)
- 📝 Standardized commits with [commitizen](https://commitizen-tools.github.io/commitizen/)
- 🐳 Containerization with [Docker](https://www.docker.com/) and [Docker Compose](https://docs.docker.com/compose/)

## Requirements

- Python 3.13+
- [UV](https://github.com/astral-sh/uv) for dependency management
- [Docker](https://www.docker.com/) and [Docker Compose](https://docs.docker.com/compose/) (optional)

## Installation

### Local Development

1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/fast_api_template.git
   cd fast_api_template
   ```

2. Use Makefile to set up the project:
   ```bash
   # Install basic dependencies
   make install

   # Or for complete development setup (including dev dependencies and pre-commit hooks)
   make dev
   ```

3. Activate the virtual environment:
   ```bash
   source .venv/bin/activate  # On Windows: .venv\Scripts\activate
   ```

### Local Development with Make

Simplify the development process using Make commands:

```bash
# Run development server
make run

# Run tests
make test

# Check code with linter
make lint

# Format code
make format

# Start Docker containers
make docker-up

# Stop Docker containers
make docker-down
```

For a complete list of commands, run:
```bash
make help
```

### Running with Docker

1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/fast_api_template.git
   cd fast_api_template
   ```

2. Run the application using Docker Compose:
   ```bash
   docker-compose up -d
   ```

3. The application will be available at http://localhost:8000, and pgAdmin at http://localhost:5050

## Development

### Running the Development Server

```bash
uvicorn app.main:app --reload
```

The server will be available at http://localhost:8000

### API Documentation

- Swagger UI: http://localhost:8000/docs
- ReDoc: http://localhost:8000/redoc

### Using pre-commit

Pre-commit automatically runs checks before each commit:

- Code formatting with Ruff
- Linting with Ruff
- Static type checking with mypy
- YAML and TOML syntax validation
- Checking for large files, merge conflicts, etc.
- Standardizing commit messages with commitizen

You can manually run all checks:

```bash
pre-commit run --all-files
```

### Commit Standards

The project uses [Conventional Commits](https://www.conventionalcommits.org/) to standardize commit messages. To create a commit, use:

```bash
cz commit
```

### Docker

The project includes Docker configuration for easy containerization:

- **Dockerfile**: multi-stage build to optimize image size
- **docker-compose.yml**: configuration to run the application with PostgreSQL and pgAdmin

Main Docker commands:

```bash
# Build and run containers
docker-compose up -d

# View logs
docker-compose logs -f

# Stop containers
docker-compose down

# Rebuild the application image
docker-compose build app
```

## License

MIT

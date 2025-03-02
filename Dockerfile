FROM python:3.13-slim

WORKDIR /app

# Install UV and dependencies
RUN pip install --no-cache-dir uv

# Copy project files
COPY pyproject.toml README.md ./

# Install dependencies
RUN uv pip install --no-cache-dir .

# Copy application code
COPY app/ ./app/

# Create non-privileged user for running the application
RUN adduser --disabled-password --gecos "" appuser
USER appuser

# Environment variables
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PORT=8000

# Expose port
EXPOSE ${PORT}

# Run application
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]

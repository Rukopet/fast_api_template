import os
from typing import Any, cast

from pydantic import AnyHttpUrl, PostgresDsn, field_validator
from pydantic_settings import BaseSettings, SettingsConfigDict


class Settings(BaseSettings):
    """Application settings."""

    model_config = SettingsConfigDict(
        env_file=".env", env_file_encoding="utf-8", case_sensitive=True
    )

    # Base settings
    PROJECT_NAME: str = "FastAPI Template"
    API_V1_STR: str = "/api/v1"
    SECRET_KEY: str = os.getenv("SECRET_KEY", "supersecretkey")
    ENVIRONMENT: str = os.getenv("ENVIRONMENT", "development")
    DEBUG: bool = ENVIRONMENT == "development"

    # CORS settings
    BACKEND_CORS_ORIGINS: list[AnyHttpUrl] = []

    @field_validator("BACKEND_CORS_ORIGINS", mode="before")
    def assemble_cors_origins(self, v: Any) -> list[str]:
        """Convert a comma-separated string to a list of URLs."""
        if isinstance(v, str) and not v.startswith("["):
            return [i.strip() for i in v.split(",")]
        if isinstance(v, list):
            return cast(list[str], v)
        if isinstance(v, str):
            return [v]
        raise ValueError(v)

    # Database
    DATABASE_URL: PostgresDsn = cast(
        PostgresDsn,
        os.getenv(
            "DATABASE_URL", "postgresql://postgres:postgres@localhost:5432/fastapi"
        ),
    )

    # JWT
    ACCESS_TOKEN_EXPIRE_MINUTES: int = 60 * 24 * 8  # 8 days
    JWT_ALGORITHM: str = "HS256"


settings = Settings()

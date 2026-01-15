# Stage 1: Build stage
FROM python:3.13-slim AS builder

WORKDIR /app

# Install build dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Create virtualenv and install dependencies
RUN python -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Stage 2: Production stage (Hardened)
FROM python:3.13-slim

# Create a non-privileged user for security 
RUN groupadd -r scraperuser && useradd -r -g scraperuser scraperuser

WORKDIR /app

# Copy only the necessary virtualenv and code from builder
COPY --from=builder /opt/venv /opt/venv
COPY python/scraper/main.py .

# Environment setup
ENV PATH="/opt/venv/bin:$PATH"
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Run as non-root user
USER scraperuser

CMD ["python", "main.py"]

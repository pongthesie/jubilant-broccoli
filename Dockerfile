FROM python:3.12-slim
ENV PIP_NO_CACHE_DIR=1 PIP_DEFAULT_TIMEOUT=60
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential curl ca-certificates \
  && rm -rf /var/lib/apt/lists/*
WORKDIR /app
COPY requirements.txt .
RUN python -m pip install -U pip setuptools wheel \
 && python -m pip -vvv install -r requirements.txt
COPY . .
CMD ["python", "app.py"]

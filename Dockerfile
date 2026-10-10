FROM python:3.10-slim-bookworm

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    COOKIES_FILE_PATH="youtube_cookies.txt"

WORKDIR /app

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        gcc \
        libffi-dev \
        ffmpeg \
        aria2 \
    && rm -rf /var/lib/apt/lists/*

COPY . /app/

RUN python -m pip install --no-cache-dir --upgrade -r requirements.txt \
    && python -m pip install --no-cache-dir pytube

CMD ["sh", "-c", "gunicorn app:app & python3 main.py"]

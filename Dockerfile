FROM python:3.11-alpine as builder

# optimise
ARG APP_DIR=/app
ARG REQUIREMENTS_FILE=requirements.txt
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYHTONBUFFERED=1 \
    APP_DIR=${APP_DIR}

RUN apk add --no-cache gcc musl-dev libffi-dev && \
    mkdir -p ${APP_DIR}

WORKDIR ${APP_DIR}


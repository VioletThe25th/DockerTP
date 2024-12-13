FROM python:3.11-alpine as builder

# Variables d'optimisation
ARG APP_DIR=/app
ARG REQUIREMENTS_FILE=requirements.txt
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYHTONBUFFERED=1 \
    APP_DIR=${APP_DIR}

RUN apk add --no-cache gcc musl-dev libffi-dev && \
    mkdir -p ${APP_DIR}

WORKDIR ${APP_DIR}

# Install dependencies
COPY ${REQUIREMENTS_FILE} ./

RUN pip install --no-cache-dir --prefix=/install -r ${REQUIREMENTS_FILE}

FROM python:3.11-alpine

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    APP_DIR=/app

WORKDIR ${APP_DIR}
COPY --from=builder /install /usr/local
COPY . ${APP_DIR}

# Copier les dépendances de l'étape builder

COPY --from=builder /installl /usr/local

# Définir le répertoire de travail

WORKDIR /app

COPY . /app

# Exposer le port pour l'application
EXPOSE 5000

# run app
CMD ["flask", "run", "--host=0.0.0.0"]
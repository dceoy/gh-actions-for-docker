# syntax=docker/dockerfile:1
ARG PYTHON_VERSION=3.12
FROM public.ecr.aws/docker/library/python:${PYTHON_VERSION}-slim AS base

SHELL ["/bin/bash", "-euo", "pipefail", "-c"]

ENV DEBIAN_FRONTEND=noninteractive
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1
ENV PYTHONIOENCODING=utf-8
ENV PIP_DISABLE_PIP_VERSION_CHECK=1
ENV PIP_NO_CACHE_DIR=1
ENV POETRY_HOME='/opt/poetry'
ENV POETRY_VIRTUALENVS_CREATE=false
ENV POETRY_NO_INTERACTION=true

RUN \
      --mount=type=cache,target=/root/.cache \
      --mount=type=bind,source=.,target=/tmp/src \
      /usr/local/bin/pip install -U poetry \
      && /usr/local/bin/poetry --directory=/tmp/src install --no-root --no-dev

WORKDIR /root

HEALTHCHECK NONE

ENTRYPOINT ["/usr/local/bin/poetry"]
CMD ["run", "python"]

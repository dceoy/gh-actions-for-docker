# syntax=docker/dockerfile:1
ARG PYTHON_VERSION=3.12
FROM public.ecr.aws/docker/library/python:${PYTHON_VERSION}-slim AS base

SHELL ["/bin/bash", "-euo", "pipefail", "-c"]

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1
ENV PYTHONIOENCODING=utf-8

RUN \
      --mount=type=cache,target=/root/.cache/pip \
      --mount=type=bind,source=.,target=/tmp/src \
      /usr/local/bin/pip install -U poetry \
      && /usr/local/bin/poetry config virtualenvs.create false \
      && /usr/local/bin/poetry install --no-interaction --no-root -C /tmp/src

WORKDIR /root

HEALTHCHECK NONE

ENTRYPOINT ["/usr/local/bin/poetry"]
CMD ["run", "python"]

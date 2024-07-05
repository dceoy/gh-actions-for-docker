FROM public.ecr.aws/docker/library/python:slim

SHELL ["/bin/bash", "-euo", "pipefail", "-c"]

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1
ENV PYTHONIOENCODING=utf-8

COPY . /tmp/src
WORKDIR /tmp/src

RUN /usr/local/bin/pip install -U --no-cache-dir poetry \
      && /usr/local/bin/poetry config virtualenvs.create false \
      && /usr/local/bin/poetry install --no-interaction --no-root

WORKDIR /root

RUN rm -rf /tmp/src

HEALTHCHECK NONE

ENTRYPOINT ["/usr/local/bin/poetry"]
CMD ["run", "python"]

FROM public.ecr.aws/docker/library/python:slim

RUN set -e \
      && /usr/local/bin/pip install -U --no-cache-dir pip poetry \
      && rm -f /tmp/get-pip.py

COPY . /tmp/src

RUN set -e \
      && cd /tmp/src \
      && /usr/local/bin/poetry config virtualenvs.create false \
      && /usr/local/bin/poetry install --no-interaction \
      && cd \
      && rm -rf /tmp/src

ENTRYPOINT ["/usr/local/bin/poetry"]
CMD ["run", "build-readme-md"]

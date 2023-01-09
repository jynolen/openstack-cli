FROM python:slim as base

RUN pip install poetry
RUN apt update && apt install -y build-essential libssl-dev
RUN mkdir -p /tmp/build /tmp/wheel

COPY poetry.lock /tmp/build
COPY pyproject.toml /tmp/build

WORKDIR /tmp/build

RUN poetry export -f requirements.txt --output requirements.txt
RUN pip wheel --wheel-dir /tmp/wheel -r /tmp/build/requirements.txt     

RUN ls /tmp/wheel
FROM python:slim

COPY --from=base /tmp/wheel /tmp

RUN apt update && apt install -y curl jq    && \
    rm -rf /var/lib/apt/lists               && \
    pip install /tmp/*.whl                  && \
    rm -rf /tmp

USER nobody:nogroup

CMD ["openstack"]
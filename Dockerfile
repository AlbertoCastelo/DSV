FROM python:3.7.8-slim

RUN apt-get update && \
    apt-get install -y libssl-dev gcc g++ git && \
    pip --no-cache-dir install --upgrade pip

ARG GITHUB_USER
ARG GITHUB_TOKEN
ARG DSGIT_CONFIGURATION_FILE


RUN echo "${GITHUB_USER}" \
    & echo "${GITHUB_TOKEN}" \
    & echo "${DSGIT_CONFIGURATION_FILE}"

ENV GITHUB_USER=$GITHUB_USER
ENV GITHUB_TOKEN=$GITHUB_TOKEN
ENV DSGIT_CONFIGURATION_FILE=$DSGIT_CONFIGURATION_FILE



COPY requirements.txt /tmp/python_engine/requirements.txt
RUN pip install -r /tmp/python_engine/requirements.txt


# RUN mkdir /workspace
WORKDIR /workspace
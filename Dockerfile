# Using a lighter base image
FROM python:3.12-slim

# Setting environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1
ARG ENV=${ENV}
ENV ENV=${ENV}

# Creating a working directory and user
WORKDIR /src
RUN adduser --disabled-password --gecos "" appuser && chown -R appuser /src

# Installation of system packages and python packages to reduce layers
RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive \
    && apt-get install -y --no-install-recommends netcat-traditional curl \
    && apt-get install -y --no-install-recommends python3-cffi python3-brotli libpango-1.0-0 libpangoft2-1.0-0 \
    && pip install --upgrade pip


# Installing dependencies
COPY ./requirements* ./
RUN pip install --no-cache-dir -r requirements.txt \
  && pip install --no-cache-dir -r requirements-unittest.txt

# Removing unused files
RUN rm requirements*
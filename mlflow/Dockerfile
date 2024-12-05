# Dockerfile to package the entire MLflow Project to make it portable for developers.
FROM python:3.10

RUN mkdir -p /mlflow/projects/code/
WORKDIR /mlflow/projects/code/

COPY src/ /mlflow/projects/code/
COPY requirements.txt /mlflow/projects/code/requirements.txt

RUN pip install --requirement requirements.txt

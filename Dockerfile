FROM apache/airflow:latest
LABEL author="Cristiano"

USER root

COPY requirements.txt /

RUN pip install -r /requirements.txt
RUN apt-get update -y && apt-get install -y curl

COPY get_data_ny_traffic.py /opt/airflow/dags

USER airflow

WORKDIR /opt/airflow


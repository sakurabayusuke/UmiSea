FROM python:3

WORKDIR /usr/src/app

COPY requirements.txt ./
RUN mkdir packages
RUN mkdir repository
RUN pip install --no-cache-dir --target ./packages -r requirements.txt
RUN apt update && apt install -y zip

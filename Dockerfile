FROM python:3.7-alpine as base

FROM base as builder
RUN mkdir /install
WORKDIR /install
COPY requirements.txt /requirements.txt
RUN pip install --install-option="--prefix=/install" -r /requirements.txt

FROM base
LABEL maintainer="torben.tietze@gmail.com"

COPY --from=builder /install /usr/local
COPY . /app
WORKDIR /app
RUN cp config/data.json.example config/data.json
CMD ["python", "bot.py"]

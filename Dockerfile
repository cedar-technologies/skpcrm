FROM python:3.5-alpine

ARG DB_USER
ARG DB_PASSWORD
ARG DB_NAME

ADD ./app ./code/app
ADD  ./tasks ./code/tasks
ADD ./migrations ./code/migrations
COPY ./requirements.txt ./code/requirements.txt
COPY ./docker-startup.sh ./code/docker-startup.sh
COPY ./config.py ./code/config.py

WORKDIR /code

RUN apk add --update bash && rm -rf /var/cache/apk/*

RUN \
 apk add --no-cache postgresql-libs && \
 apk add --no-cache --virtual .build-deps gcc musl-dev postgresql-dev

RUN pip install -r requirements.txt --no-cache-dir
RUN pip install -r app/requirements.postgres.txt --no-cache-dir
RUN apk --purge del .build-deps

CMD ["/bin/bash", "docker-startup.sh"]
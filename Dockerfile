FROM python:alpine3.7

# Needed for alpine
RUN apk update && apk add postgresql-dev gcc python3-dev musl-dev build-base jpeg-dev zlib-dev curl libffi-dev
RUN pip install -U pip
WORKDIR /code
VOLUME /code
COPY ./requirements.txt /code/requirements.txt
# RUN pip install -r requirements.txt
RUN LIBRARY_PATH=/lib:/usr/lib /bin/sh -c "pip install -r requirements.txt"


COPY ./indieweblogin /code/indieweblogin/

WORKDIR /code/indieweblogin
CMD ["gunicorn", "-b 0.0.0.0:8000",  "indieweblogin.wsgi"]
HEALTHCHECK CMD curl --fail http://localhost:8000/ || exit 1

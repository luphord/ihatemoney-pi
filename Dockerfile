FROM python:3.10-alpine

RUN pip install --no-cache-dir SQLAlchemy==1.3.0 ihatemoney==5.1.1
RUN apk update && apk add openssl sqlite

COPY ./run_ihatemoney.sh /bin
COPY ./trigger_bill_update.sql /bin

EXPOSE 80

ENTRYPOINT [ "run_ihatemoney.sh" ]
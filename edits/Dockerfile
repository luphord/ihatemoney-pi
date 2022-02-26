FROM alpine:3.10

RUN apk add --no-cache \
        python3 sqlite

EXPOSE 80
WORKDIR /usr/src/app

COPY cgi-bin ./cgi-bin

CMD python3 -m http.server --bind 0.0.0.0 --cgi 80
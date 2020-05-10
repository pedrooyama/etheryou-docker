FROM python:3
WORKDIR /src/app
COPY ./common/config.sh .
COPY ./init.sh .
ENTRYPOINT ["bash", "./init.sh"]

